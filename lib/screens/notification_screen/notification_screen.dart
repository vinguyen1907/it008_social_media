import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/widgets/header.dart';
import 'package:it008_social_media/widgets/status_tile_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static const id = 'notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        // header
        Header(
          title: 'Notifications',
          prefixIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.icArrowLeft,
                width: 18, height: 18, fit: BoxFit.contain),
          ),
        ),
        SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalMargin, vertical: 15),
              child: Text('Today',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(
                        bottom: 20,
                        left: Dimensions.defaultHorizontalMargin,
                        right: Dimensions.defaultHorizontalMargin),
                    // margin: const EdgeInsets.symmetric(
                    //     horizontal: Dimensions.defaultHorizontalMargin),
                    child: StatusTile(
                        title: 'User 1 commented on your post',
                        subtitle: '1hrs ago',
                        backgroundImageUrl:
                            'https://thumbs.dreamstime.com/b/indian-man-photographer-digital-camera-photography-profession-people-concept-happy-over-grey-background-160101839.jpg'),
                  );
                })
          ],
        )),
      ],
    )));
  }
}
