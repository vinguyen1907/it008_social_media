import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/profile/widget/description_text.dart';
import 'package:it008_social_media/screens/profile/widget/follow_button.dart';
import 'package:it008_social_media/screens/profile/widget/message_button.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionText(),
          Row(
            children: [
              MessageButton(),
              FollowButton(),
            ],
          ),
        ],
      ),
    );
  }
}
