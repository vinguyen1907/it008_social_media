import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
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
                "Abdul Quayyum",
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
      ),
    );
  }
}
