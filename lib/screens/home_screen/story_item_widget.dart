import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    Key? key,
    required this.size,
    required this.imageUrl,
    this.hasBorder = false,
    required this.label,
    this.smallImage,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String imageUrl;
  final bool hasBorder;
  final String label;
  final Widget? smallImage;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => onTap(),
            child: SizedBox(
              height: size.height / 8 + 12.5,
              child: Stack(
                children: [
                  Container(
                      height: size.height / 8,
                      width: size.width / 5.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: hasBorder ? Colors.black : Colors.transparent,
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(imageUrl, fit: BoxFit.cover))),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppColors.lightGreyColor,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
                        child: smallImage ??
                            SvgPicture.asset(AppAssets.icPlus,
                                height: 12,
                                width: 12,
                                fit: BoxFit.contain,
                                color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Text(label, style: AppStyles.storyLabel),
      ],
    );
  }
}
