import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/chat/widget/icon_button.dart';
import 'package:it008_social_media/screens/chat/widget/message_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../change_notifies/user_provider.dart';

class ChatRoomPage extends StatefulWidget {
  final String uid;
  final String messagesId;
  final String contactname;
  final String contactphotoURl;

  const ChatRoomPage({Key? key, required this.messagesId, required this.contactname, required this.contactphotoURl, required this.uid})
      : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  var _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(
                widget.contactname,
                style: AppStyles.postUserName.copyWith(
                  fontSize: 18,
                  height: 27 / 18,
                ),
              ),
              Text(
                "Last seen 2hrs ago",
                style: AppStyles.postUploadTime.copyWith(
                  fontSize: 10,
                  height: 15 / 10,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19,right: 19,top: 34,bottom: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(widget.messagesId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                            snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                            return MessageWidget(map: map, uid: userProvider.getUser?.id??"",);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: snapshot.data?.docs.length??0,
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.whiteColor,
                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 21),
                child: Row(
                  children: [
                    IconMessageButton(onPress: () {}, iconPath: "assets/images/mic.png"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: IconMessageButton(onPress: () {
                        getImage(username: userProvider.getUser?.userName??"", photoUrl:userProvider.getUser?.avatarImageUrl??"", uid: userProvider.getUser?.id??"");
                      }, iconPath: "assets/images/image.png"),
                    ),
                    IconMessageButton(onPress: () {}, iconPath: "assets/images/game.png"),
                    SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryMainColor,
                          ),
                          hintText: "Type your message...",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onSendMessage(
                          username: userProvider.getUser?.userName??"",
                          photoUrl: userProvider.getUser?.avatarImageUrl??"",
                          uid: userProvider.getUser?.id??"",
                        );
                      },
                      icon: SvgPicture.asset("assets/icons/send.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSendMessage({required String username, required String photoUrl,required String uid}) async {
    if (_messageController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Map<String, dynamic> messages = {
        "uid" : widget.uid,
        "sendby": uid,
        "message": _messageController.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
        "lasttime": DateFormat('hh:mm a').format(DateTime.now()),
      };

      await _firestore.collection('messages').doc(widget.messagesId).collection('chats').add(messages);

      await _firestore.collection('messages').doc(widget.messagesId).set({
        "user1": widget.contactname,
        "user2": username,
        "photoUrl1": photoUrl == null || photoUrl == "" ?"https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg":photoUrl,
        "photoUrl2": widget.contactphotoURl == null || widget.contactphotoURl == ""?"https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg":widget.contactphotoURl,
        "message": _messageController.text,
        "type": "text",
        "lasttime": DateFormat('hh:mm a').format(DateTime.now()),
        "Members": [uid, widget.uid],
        'RoomId': widget.messagesId,
        'uid1':widget.uid,
        'uid2':uid,
      });
      _messageController.clear();
    } else {
      print("Enter Some Text");
    }
  }

  Future getImage({required String username, required String photoUrl,required String uid}) async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage(userName: username, photoUrl: photoUrl,uid: uid);
      }
    });
  }

  Future uploadImage(
      {required String userName, required String photoUrl,required String uid}) async {
    FocusScope.of(context).unfocus();
    String fileName = Uuid().v1();
    var ref = FirebaseStorage.instance.ref().child('images').child("$fileName");
    var uploadTask = await ref.putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    await _firestore
        .collection('messages')
        .doc(widget.messagesId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": uid,
      "message": downloadUrl,
      "type": "img",
      "time": FieldValue.serverTimestamp(),
      "lasttime": DateFormat('hh:mm a').format(DateTime.now()),
    });

    await _firestore.collection('messages').doc(widget.messagesId).set({
      "user1": widget.contactname,
      "user2": userName,
      "photoUrl1": photoUrl == null || photoUrl == "" ?"https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg":photoUrl,
      "photoUrl2": widget.contactphotoURl == null || widget.contactphotoURl == ""?"https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg":widget.contactphotoURl,
      "message": "Sent an image",
      "type": "image",
      "lasttime": DateFormat('hh:mm a').format(DateTime.now()),
      "Members": [uid, widget.uid],
      'RoomId': widget.messagesId,
      'uid1':widget.uid,
      'uid2':uid,
    });
  }

}
