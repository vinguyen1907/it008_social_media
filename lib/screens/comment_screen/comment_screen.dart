import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/widgets/header.dart';
import 'package:it008_social_media/widgets/input_and_send.dart';
import 'package:it008_social_media/widgets/post_widget.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  static const id = 'comment_screen';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(
          title: 'Comments',
          prefixIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.icArrowLeft,
                width: 18, height: 18, fit: BoxFit.contain),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PostWidget(
              //     postImageUrl: Post.listPosts[0].imageUrl,
              //     avatarImageUrl:
              //         'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              const SizedBox(height: 10),

              // input comment
              Container(
                height: size.height * 0.05,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalMargin),
                child: Row(children: [
                  ClipOval(
                      child: Image.network(
                    "https://scontent.fsgn5-3.fna.fbcdn.net/v/t39.30808-6/305767392_1705138999870466_4301266471825436049_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=TEekvpIie7AAX8MP9tZ&_nc_ht=scontent.fsgn5-3.fna&oh=00_AfBAl-UE4cWbamX1TpV0WXgddUiWgUpEJvh7kXvLPRwlzA&oe=6377CDBD",
                    height: size.height * 0.05,
                  )),
                  const SizedBox(width: 10),
                  InputAndSendWidget(
                    size: size,
                    hintText: "Add a comment...",
                    borderColor: const Color(0xff4D4D4D),
                    hintColor: const Color(0xffcccccc),
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.defaultHorizontalMargin,
                    top: Dimensions.smallVerticalMargin),
                child: Text('Comments',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultHorizontalMargin,
                          vertical: Dimensions.smallVerticalMargin),
                      child: CommentWidget(index: index),
                    );
                  })
            ],
          )),
        ),
      ],
    )));
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.icHeart,
                      width: 15, fit: BoxFit.cover),
                  const Text(" ${27}", style: AppStyles.postReaction),
                ],
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User $index', style: AppStyles.postUserName),
                const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra aliquam, congue habitasse tortor. Fringilla nunc aliquam volutpat suscipit porttitor in quis sagittis hac. Tellus sed ac libero',
                    style: AppStyles.postDescription)
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text('2hrs ago',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
