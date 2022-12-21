import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';

class InputAndSendWidget extends StatelessWidget {
  const InputAndSendWidget({
    Key? key,
    required this.size,
    required this.hintText,
    required this.borderColor,
    required this.hintColor,
    required this.textColor,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final Color borderColor;
  final Color hintColor;
  final Color textColor;
  final Function onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          // height: size.height * 0.05,
          padding:
              const EdgeInsets.only(left: Dimensions.defaultHorizontalMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1,
              color: borderColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: textColor,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: hintColor,
                    ),
                    hintText: hintText,
                  ),
                ),
              ),
              IconButton(
                iconSize: 25,
                onPressed: () => onPressed(),
                icon: SvgPicture.asset(
                  AppAssets.icSend,
                  height: 25,
                ),
              ),
            ],
          )),
    );
  }
}
