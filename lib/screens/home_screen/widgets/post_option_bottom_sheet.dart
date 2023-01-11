import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class PostOptionsBottomSheet extends StatelessWidget {
  const PostOptionsBottomSheet(
      {super.key, required this.onDeletePost, required this.onEditPost});

  final VoidCallback onDeletePost;
  final VoidCallback onEditPost;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width - 2 * Dimensions.defaultHorizontalMargin,
        padding: const EdgeInsets.only(bottom: 10),
        child: Wrap(
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              width: size.width - 2 * Dimensions.defaultHorizontalMargin,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                        onPressed: onDeletePost,
                        child: Text("Delete Post",
                            style: AppStyles.bottomSheetSelection
                                .copyWith(color: Colors.red))),
                  ),
                  Container(height: 1, color: Colors.black12),
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                        onPressed: onEditPost,
                        child: const Text("Edit Post",
                            style: AppStyles.bottomSheetSelection)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: Size(
                      size.width - 2 * Dimensions.defaultHorizontalMargin, 50),
                  backgroundColor: AppColors.primaryMainColor,
                  foregroundColor: Colors.white),
              child: Text("Cancel",
                  style: AppStyles.bottomSheetSelection
                      .copyWith(color: Colors.white)),
            ),
          ],
        ));
  }
}
