import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:it008_social_media/add_new_podcast_screen/add_new_podcast_screen.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Podcast',
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xffcccccc).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                ))
          ],
        ));
  }
}
