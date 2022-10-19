import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final String title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
      width: double.infinity,
      // color: Colors.red,
      child: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(title,
                  textAlign: TextAlign.center, style: AppStyles.headerTitle),
            )),
        prefixIcon != null ? prefixIcon! : Container(),
        Positioned(
            right: 0, child: suffixIcon != null ? suffixIcon! : Container()),
      ]),
    );
  }
}
