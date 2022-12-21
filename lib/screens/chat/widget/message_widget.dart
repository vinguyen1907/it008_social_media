import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';

import '../../../constants/app_styles.dart';

class MessageWidget extends StatelessWidget {
  final Map<String, dynamic> map;
  final String uid;

  const MessageWidget({Key? key, required this.map, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkUser = map['sendby'] == uid;
    return Align(
      alignment: checkUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Visibility(
            visible: map['type'] == "text",
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 206),
                  decoration: BoxDecoration(
                    color: checkUser ? AppColors.tetFieldColor : AppColors.primaryMainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(checkUser ? 20 : 0),
                      bottomRight: Radius.circular(checkUser ? 0 : 20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 17),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map['message'],
                        style: AppStyles.postReaction.copyWith(
                          fontWeight: FontWeight.w500,
                          color: checkUser ? AppColors.primaryTextColor : AppColors.whiteColor,
                        ),
                        maxLines: null,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          map['lasttime'],
                          style: AppStyles.postReaction.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 7,
                            height: 11 / 7,
                            color: checkUser ? AppColors.primaryTextColor : AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: map['type'] == "img",
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 206),
                  decoration: BoxDecoration(
                    color: checkUser ? AppColors.tetFieldColor : AppColors.primaryMainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(checkUser ? 20 : 0),
                      bottomRight: Radius.circular(checkUser ? 0 : 20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 17),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(map["message"]),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          map['lasttime'],
                          style: AppStyles.postReaction.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 7,
                            height: 11 / 7,
                            color: checkUser ? AppColors.primaryTextColor : AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
