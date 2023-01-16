import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/chat/chat_room_page.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../change_notifies/user_provider.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';

class SearchListWidget extends StatefulWidget {
  final bool isSearching;
  final ValueChanged<bool> onSelected;
  const SearchListWidget({Key? key, required this.isSearching, required this.onSelected}) : super(key: key);

  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  bool selected = false;
  var searchController = TextEditingController();
  BehaviorSubject<bool> isSearching = BehaviorSubject.seeded(false);
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 70,bottom: 16,left: 29,right: 29),
        child: Column(
          children: [
            SizedBox(
              height: 34,
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  if(value == ""){
                      selected = false;
                      widget.onSelected(selected);
                  }else{
                      selected = true;
                      widget.onSelected(selected);
                  }
                },
                style: AppStyles.searchText,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  hintStyle: AppStyles.searchHintText,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AppAssets.icMagnifier),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder:  const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                        color: AppColors.primaryMainColor, width: 1),
                  ),
                  focusedBorder:  const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: AppColors.primaryMainColor),
                  ),
                ),
              ),
            ),
           SizedBox(height: 11,),
           Visibility(
             visible: searchController.text != "",
             child: Container(
               padding: const EdgeInsets.only(top: 9,bottom: 14,left: 16,right: 16),
               decoration: BoxDecoration(
                 color: AppColors.whiteColor,
                 borderRadius: BorderRadius.circular(10),
               ),

               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,

                 children: [
                   const Text('Search results',
                       style: TextStyle(
                           fontFamily: 'Poppins',
                           fontSize: 16,
                           fontWeight: FontWeight.w600)),
                   StreamBuilder(
                       stream:
                       FirebaseFirestore.instance.collection('messages').where("Members", arrayContains: userProvider.getUser?.id??"").where(
                         'message',
                         isGreaterThanOrEqualTo: searchController.text,
                       ).snapshots(),
                       builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                         if (snapshot.connectionState == ConnectionState.waiting) {
                           return const Center(
                             child: CircularProgressIndicator(),
                           );
                         }
                         return ListView.separated(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           itemBuilder: (BuildContext context, int index) {
                             return InkWell(
                               onTap: () {
                                 String roomId = snapshot.data?.docs[index].data()['RoomId'];
                                 String contactname = snapshot.data?.docs[index].data()['user1'] == userProvider.getUser?.userName
                                     ? snapshot.data?.docs[index].data()['user2']
                                     : snapshot.data?.docs[index].data()['user1'];
                                 String contactphotoURl = snapshot.data?.docs[index].data()['photoUrl1'] == userProvider.getUser?.userName
                                     ? snapshot.data?.docs[index].data()['photoUrl1']
                                     : snapshot.data?.docs[index].data()['photoUrl2'];
                                 String contactId = snapshot.data?.docs[index].data()['uid1'] == userProvider.getUser?.id
                                     ? snapshot.data?.docs[index].data()['uid2']
                                     : snapshot.data?.docs[index].data()['uid1'];

                                 if (roomId != '') {
                                   Navigator.of(context).push(
                                     MaterialPageRoute(
                                       builder: (_) => ChatRoomPage(
                                         contactname: contactname,
                                         contactphotoURl: contactphotoURl,
                                         messagesId: roomId,
                                         uid: contactId,
                                       ),
                                     ),
                                   );
                                 }
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       ClipOval(
                                         child: Image.network(
                                           snapshot.data?.docs[index].data()['photoUrl1'] == userProvider.getUser?.avatarImageUrl
                                               ? snapshot.data?.docs[index].data()['photoUrl2'] ??
                                               "https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg"
                                               : snapshot.data?.docs[index].data()['photoUrl1'] ??
                                               "https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg",
                                           width: 49,
                                           height: 49,
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                       SizedBox(
                                         width: 5,
                                       ),
                                       Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             snapshot.data?.docs[index].data()['user1'] == userProvider.getUser?.userName
                                                 ? snapshot.data?.docs[index].data()['user2']
                                                 : snapshot.data?.docs[index].data()['user1'],
                                             style: AppStyles.postUserName.copyWith(fontSize: 12, height: 18 / 12),
                                           ),
                                           Text(
                                             snapshot.data?.docs[index].data()['message'],
                                             style:
                                             AppStyles.storyLabel.copyWith(fontSize: 10, height: 15 / 10, color: AppColors.primaryMainColor),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             );
                           },
                           separatorBuilder: (BuildContext context, int index) => SizedBox(
                             height: 21,
                           ),
                           itemCount: snapshot.data?.docs.length??0,
                         );
                       }),
                 ],
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
