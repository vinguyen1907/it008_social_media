import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class UserInformationWidget extends StatelessWidget {
  final Icon? icon;
  const UserInformationWidget({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28, top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
                        width: 67,
                        height: 67,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Oyin Dolapo",
                        style: AppStyles.postUserName.copyWith(fontSize: 18),
                      ),
                      Text(
                        "Abeokuta, Ogun",
                        style: AppStyles.postUserName.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: icon ?? Icon(Icons.logout)),
            ],
          ),
        ),
      ],
    );
  }
}
