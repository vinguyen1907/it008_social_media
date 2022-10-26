import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/chat/chat_room_page.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryTextColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Chats",
          style: AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 17,
              ),
              SizedBox(
                height: 34,
                child: TextFormField(
                  style: AppStyles.searchText,
                  decoration: InputDecoration(
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
                      borderSide: BorderSide(
                          color: AppColors.primaryMainColor, width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColors.primaryMainColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: Text(
                  'Frequently chatted',
                  style: AppStyles.postUploadTime
                      .copyWith(height: 21 / 14, fontSize: 14),
                ),
              ),
              Container(
                height: 53,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 49,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              "https://scontent.fsgn8-4.fna.fbcdn.net/v/t39.30808-6/312576837_481329224039824_1971902793594846384_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=wBUYKw46M3YAX_pOyT7&_nc_ht=scontent.fsgn8-4.fna&oh=00_AT9lDJ_i0zv-RyzB9gFVUG8WjKA-vzN2SDUkxHkiA7s_Vg&oe=635C103E",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: -3,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: AppColors.primaryHertButtonColor,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 16,
                  ),
                  itemCount: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 16),
                child: Text(
                  'Frequently chatted',
                  style: AppStyles.postUploadTime
                      .copyWith(height: 21 / 14, fontSize: 14),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ChatRoomPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/305767392_1705138999870466_4301266471825436049_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=AsULsruoGWEAX_mHDzP&_nc_ht=scontent.fsgn3-1.fna&oh=00_AT_a-s9PIXh1whMI5WR0K6QHgxI8k5bKhOam1Z5OdMt5kw&oe=635C1E3D',
                                width: 49,
                                height: 49,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chris uil",
                                  style: AppStyles.postUserName
                                      .copyWith(fontSize: 12, height: 18 / 12),
                                ),
                                Text(
                                  "Send me d link bro",
                                  style: AppStyles.storyLabel.copyWith(
                                      fontSize: 10,
                                      height: 15 / 10,
                                      color: AppColors.primaryMainColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "08:43",
                              style: AppStyles.storyLabel.copyWith(
                                  fontSize: 10,
                                  height: 15 / 10,
                                  color: AppColors.timeMessageColor),
                            ),
                            SvgPicture.asset(
                              height: 6,
                              width: 8,
                              AppAssets.icCheck,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 21,
                ),
                itemCount: 8,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
