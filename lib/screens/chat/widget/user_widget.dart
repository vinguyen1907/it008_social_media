import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class UserWidget extends StatelessWidget {
  final snap;
  final VoidCallback onPress;
  const UserWidget({super.key, this.snap, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: ()=>onPress.call(),
          child: SizedBox(
            height: 49,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                snap["avatarImageUrl"] != null &&  snap["avatarImageUrl"] != ""
                    ? snap["avatarImageUrl"] :"https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg"
                   ,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          right: -3,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                color: AppColors.primaryStatusColor,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ],
    );
  }
}
