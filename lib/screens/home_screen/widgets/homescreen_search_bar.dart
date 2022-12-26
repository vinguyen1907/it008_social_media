import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/widgets/search_bar_widget.dart';

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
              IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.pushNamed(context, NotificationScreen.id);
                  },
                  icon: SvgPicture.asset(AppAssets.icNotification,
                      width: 18, fit: BoxFit.cover)),
            ],
          ),
        ),
      ),
    );
  }
}
