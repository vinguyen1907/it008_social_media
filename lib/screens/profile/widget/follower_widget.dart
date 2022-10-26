import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class FollowerWidget extends StatelessWidget {
  const FollowerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                  color: AppColors.whiteColor.withOpacity(0.25))
            ]),
            width: size.width,
            child: Divider(
              thickness: 1,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 29, bottom: 7, top: 5),
          child: Text(
            'Followers',
            style:
                AppStyles.postUserName.copyWith(fontSize: 14, height: 21 / 14),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 28),
          height: 78,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/307734002_1985914361609559_5797116281487970274_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=JBQ9DkpNDqsAX_WTXVb&_nc_ht=scontent.fsgn8-2.fna&oh=00_AT-aJ4xMaeSA_hqXJHh1XspMYT4TFIYDmUPap5agMn3ujw&oe=635B693A',
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    'Elijah',
                    style:
                    AppStyles.postUserName.copyWith(fontSize: 10, height: 15 / 10),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 26,
            ),
            itemCount: 8,
          ),
        ),
        SizedBox(height: 12,),
        Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                  color: AppColors.whiteColor.withOpacity(0.25))
            ]),
            width: size.width,
            child: Divider(
              thickness: 1,
            )),

      ],
    );
  }
}
