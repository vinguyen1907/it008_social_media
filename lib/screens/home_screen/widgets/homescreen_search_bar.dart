import 'package:badges/badges.dart' as badge;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenSearchBar extends StatefulWidget {
  const HomeScreenSearchBar({super.key});

  @override
  State<HomeScreenSearchBar> createState() => _HomeScreenSearchBarState();
}

class _HomeScreenSearchBarState extends State<HomeScreenSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    return Hero(
      tag: 'search_bar',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: size.width - Dimensions.defaultHorizontalMargin,
          height: 35,
          margin: const EdgeInsets.only(
              top: 20, left: Dimensions.defaultHorizontalMargin),
          child: Row(
            children: [
              SearchBar(
                controller: searchController,
                readOnly: true,
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.id);
                },
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: notificationsRef
                      .doc(user.id)
                      .collection("notifications")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int count = snapshot.data!.docs
                          .where((element) => !NotificationModel.fromJson(
                                  element.data() as Map<String, dynamic>)
                              .isSeen)
                          .length;

                      if (count > 0) {
                        return badge.Badge(
                          badgeContent: Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Text("$count",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ),
                          position:
                              badge.BadgePosition.topEnd(top: -12, end: 5),
                          child: const NotificationButton(),
                        );
                      } else {
                        return const NotificationButton();
                      }
                    } else {
                      return const NotificationButton();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.pushNamed(context, NotificationScreen.id);
        },
        icon: SvgPicture.asset(AppAssets.icNotification,
            width: 18, fit: BoxFit.cover));
  }
}
