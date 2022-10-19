import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/widgets/header.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  static const id = 'add_story_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Header(
          title: 'Add to story',
          prefixIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.icArrowLeft,
                width: 18, height: 18, fit: BoxFit.contain),
          ),
        ),
        const Spacer(),
        Column(
          children: [
            SvgPicture.asset(AppAssets.icArrowUp,
                width: 37, height: 13.5, fit: BoxFit.contain),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalMargin),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AppAssets.icOutlinedImage,
                            width: 25, height: 25, fit: BoxFit.contain)),
                    IconButton(
                        iconSize: 60,
                        splashRadius: 30,
                        onPressed: () {},
                        icon: SvgPicture.asset(AppAssets.icCircle,
                            width: 60, height: 60, fit: BoxFit.contain)),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(AppAssets.icSwitchCamera,
                            color: Colors.black.withOpacity(0.5),
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain)),
                  ]),
            ),
            const SizedBox(height: 10),
            const Text('Tap for photo',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400))
          ],
        ),
        const SizedBox(height: 10),
      ],
    )));
  }
}
