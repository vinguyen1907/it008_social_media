import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/add_new_podcast_screen/add_new_podcast_screen.dart';
import 'package:it008_social_media/constants/app_colors.dart';

class AddNewPodcastWidget extends StatelessWidget {
  const AddNewPodcastWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffcccccc).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Write your new story by podcast',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewPodcastScreen.id);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0),
              child: const Text('Add new'),
            )
          ],
        ));
  }
}
