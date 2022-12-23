import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.controller,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.autofocus,
  }) : super(key: key);

  final TextEditingController controller;
  final bool? readOnly;
  final Function? onTap;
  final Function(String keyword)? onChanged;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextFormField(
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      controller: controller,
      onTap: () {
        if (onTap != null && readOnly != null && readOnly == true) {
          onTap!();
        }
      },
      onChanged: (String value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      style: AppStyles.searchText,
      decoration: InputDecoration(
        isDense: false,
        hintText: 'Type something...',
        hintStyle: AppStyles.searchHintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(AppAssets.icMagnifier),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: AppColors.primaryMainColor, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: AppColors.primaryMainColor),
        ),
      ),
    ));
  }
}
