import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/verify_story/verify_story.dart';

class ChooseImageModalBottomSheet extends StatefulWidget {
  const ChooseImageModalBottomSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ChooseImageModalBottomSheet> createState() =>
      _ChooseImageModalBottomSheetState();
}

class _ChooseImageModalBottomSheetState
    extends State<ChooseImageModalBottomSheet> {
  Future<String?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        print("No image selected");
        return null;
      }
      return image.path;
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size.width - 2 * Dimensions.defaultHorizontalMargin,
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
              width: widget.size.width - 2 * Dimensions.defaultHorizontalMargin,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final String? path = await pickImage(ImageSource.camera);

                      if (!mounted) return;

                      if (path != null) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, VerifyStoryScreen.id,
                            arguments: path);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("Camera",
                            style: AppStyles.bottomSheetSelection)),
                  ),
                  Container(height: 1, color: Colors.black12),
                  GestureDetector(
                    onTap: () async {
                      final String? path = await pickImage(ImageSource.gallery);

                      if (!mounted) return;

                      if (path != null) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, VerifyStoryScreen.id,
                            arguments: path);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("Photo Library",
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
                      widget.size.width -
                          2 * Dimensions.defaultHorizontalMargin,
                      50),
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
