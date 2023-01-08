import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_assets.dart';

class StoryInstruction extends StatelessWidget {
  const StoryInstruction(
      {super.key,
      required this.currentIndex,
      required this.groupLength,
      required this.size});

  final int currentIndex;
  final int groupLength;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0 && groupLength > 1) {
      return Positioned(
          bottom: 10,
          child: Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppAssets.icTap,
                        height: 30, color: Colors.grey[200]),
                    const SizedBox(height: 5),
                    Text('Previous',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: 'Poppins',
                            fontSize: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppAssets.icTap,
                        height: 30, color: Colors.grey[200]),
                    const SizedBox(height: 5),
                    Text('Next',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: 'Poppins',
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ));
    } else if (currentIndex == groupLength - 1) {
      return Positioned(
        bottom: 10,
        right: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(AppAssets.icSlideLeft,
                height: 30, color: Colors.grey[200]),
            const SizedBox(height: 5),
            Text('Slide left to next story',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontFamily: 'Poppins',
                    fontSize: 12)),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
