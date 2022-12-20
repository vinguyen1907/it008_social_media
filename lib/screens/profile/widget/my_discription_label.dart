import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../change_notifies/user_provider.dart';

class MyDescriptionLabel extends StatelessWidget {
  const MyDescriptionLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 29, right: 79,top: 12),
      child: Text(
        userProvider.getUser?.about??"",
        style: AppStyles.postUploadTime
            .copyWith(fontSize: 12, height: 18 / 12),
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }
}
