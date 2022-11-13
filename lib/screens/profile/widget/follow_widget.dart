import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/profile/widget/follow_infomation_widget.dart';

class FollowWidget extends StatelessWidget {
  const FollowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14,bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FollowInformationWidget(label: 'Posts',num: 870,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            height: 43,
            child: VerticalDivider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          FollowInformationWidget(label: 'Following',num: 870,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            height: 43,
            child: VerticalDivider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          FollowInformationWidget(label: 'Followers',num: 870,),
        ],
      ),
    );
  }
}
