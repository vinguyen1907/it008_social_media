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
        
      ],
    );
  }
}
