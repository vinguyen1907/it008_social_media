import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:provider/provider.dart';

class UserInformationWidget extends StatelessWidget {
  final Icon? icon;
  const UserInformationWidget({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
                        userProvider.getUser?.avatarImageUrl ?? "",
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
                        userProvider.getUser!.userName ?? "",
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
