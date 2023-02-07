import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/chat/chat_room_page.dart';
import 'package:it008_social_media/screens/chat/widget/user_widget.dart';
import 'package:it008_social_media/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../change_notifies/user_provider.dart';
import 'widget/seach_bg.dart';
import 'widget/search_list_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String chatRoomId(String user1, String user2) {
    if (user1.compareTo(user2) == -1) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  //bool isSearching = false;

  BehaviorSubject<bool> isSearching = BehaviorSubject.seeded(false);
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.arrow_back_ios_new,
            //     color: AppColors.primaryTextColor,
            //   ),
            // ),
            centerTitle: true,
            title: Text(
              "Chats",
              style: AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 10),
                        child: Text(
                          'Frequently chatted',
                          style: AppStyles.postUploadTime.copyWith(height: 21 / 14, fontSize: 14),
                        ),
                      ),
                      StreamBuilder(
                          stream:
                              FirebaseFirestore.instance.collection('users').where('id', isNotEqualTo: userProvider.getUser?.id ?? "").snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container(
                              height: 53,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return UserWidget(
                                    onPress: () {
                                      String roomId = '';
                                      roomId = chatRoomId(
                                        userProvider.getUser!.id ?? "",
                                        snapshot.data!.docs[index].data()['id'],
                                      );
                                      if (roomId != '') {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ChatRoomPage(
                                              uid: snapshot.data?.docs[index].data()['id'] ?? "",
                                              contactname: snapshot.data?.docs[index].data()['userName'],
                                              contactphotoURl: snapshot.data?.docs[index].data()["avatarImageUrl"] ?? "",
                                              messagesId: roomId,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    snap: snapshot.data!.docs[index].data(),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => SizedBox(
                                  width: 16,
                                ),
                                itemCount: (snapshot.data! as dynamic).docs.length,
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 16),
                        child: Text(
                          'All Messages',
                          style: AppStyles.postUploadTime.copyWith(height: 21 / 14, fontSize: 14),
                        ),
                      ),
                      StreamBuilder(
                          stream:
                              FirebaseFirestore.instance.collection('messages').where("Members", arrayContains: userProvider.getUser!.id).snapshots(),
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
                                    String roomId = snapshot.data!.docs[index].data()['RoomId'];
                                    String contactname = snapshot.data!.docs[index].data()['user1'] == userProvider.getUser?.userName
                                        ? snapshot.data!.docs[index].data()['user2']
                                        : snapshot.data!.docs[index].data()['user1'];
                                    String contactphotoURl = snapshot.data!.docs[index].data()['photoUrl1'] == userProvider.getUser?.userName
                                        ? snapshot.data!.docs[index].data()['photoUrl1']
                                        : snapshot.data!.docs[index].data()['photoUrl2'];
                                    String contactId = snapshot.data!.docs[index].data()['uid1'] == userProvider.getUser?.id
                                        ? snapshot.data!.docs[index].data()['uid2']
                                        : snapshot.data!.docs[index].data()['uid1'];

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
                                              snapshot.data!.docs[index].data()['photoUrl1'] == userProvider.getUser?.avatarImageUrl
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
                                                snapshot.data!.docs[index].data()['user1'] == userProvider.getUser?.userName
                                                    ? snapshot.data!.docs[index].data()['user2']
                                                    : snapshot.data!.docs[index].data()['user1'],
                                                style: AppStyles.postUserName.copyWith(fontSize: 12, height: 18 / 12),
                                              ),
                                              Text(
                                                snapshot.data!.docs[index].data()['message'],
                                                style:
                                                    AppStyles.storyLabel.copyWith(fontSize: 10, height: 15 / 10, color: AppColors.primaryMainColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index].data()['lasttime'],
                                            style: AppStyles.storyLabel.copyWith(fontSize: 10, height: 15 / 10, color: AppColors.timeMessageColor),
                                          ),
                                          SvgPicture.asset(
                                            height: 6,
                                            width: 8,
                                            AppAssets.icCheck,
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
                              itemCount: snapshot.data!.docs.length,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<bool>(
          stream: isSearching,
          builder: (context, snapshot) {
            return SearchBackgound(isSearching: snapshot.data??false,);
          }
        ),
        StreamBuilder<bool>(
          stream: isSearching,
          builder: (context, snapshot) {
            return Column(
              children: [
                SearchListWidget(
                  isSearching: snapshot.data??false,
                  onSelected: (value){
                    isSearching.add(value);
                  },
                ),
              ],
            );
          }
        ),
      ],
    ));
  }
}
