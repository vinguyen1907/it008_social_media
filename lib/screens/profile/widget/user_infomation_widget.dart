import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class UserInformationWidget extends StatelessWidget {
  final Icon? icon;
  const UserInformationWidget({Key? key,  this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28, top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ClipOval(
                      child: Image.network(
                        'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/305767392_1705138999870466_4301266471825436049_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=AsULsruoGWEAX_mHDzP&_nc_ht=scontent.fsgn3-1.fna&oh=00_AT_a-s9PIXh1whMI5WR0K6QHgxI8k5bKhOam1Z5OdMt5kw&oe=635C1E3D',
                        width: 67,
                        height: 67,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Oyin Dolapo",
                        style: AppStyles.postUserName.copyWith(fontSize: 18),
                      ),
                      Text(
                        "Abeokuta, Ogun",
                        style: AppStyles.postUserName.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: icon??Icon(Icons.logout)),
            ],
          ),
        ),
      ],
    );
  }
}
