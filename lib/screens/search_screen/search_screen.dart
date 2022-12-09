import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String id = 'search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Users> searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
            width: size.width,
            height: 35,
            margin: const EdgeInsets.only(
                top: 20,
                left: Dimensions.defaultHorizontalMargin,
                right: Dimensions.defaultHorizontalMargin),
            alignment: Alignment.center,
            child: Row(children: [
              SearchBar(
                controller: _searchController,
                autofocus: true,
                onChanged: (keyword) => search(keyword),
              ),
            ])),
        const SizedBox(height: 10),
        searchResult.isEmpty
            ? Text("No search result.", style: AppStyles.noItemText)
            : Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.defaultHorizontalMargin,
                            bottom: Dimensions.smallVerticalMargin),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: searchResult[index].avatarImageUrl!,
                                placeholder: (context, url) =>
                                    Container(color: Colors.grey[200]),
                                errorWidget: (context, url, error) {
                                  return Container(
                                      color: Colors.grey[200],
                                      child:
                                          Image.asset(AppAssets.defaultImage));
                                  // return Container(color: Colors.red);
                                },
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(searchResult[index].fullName ?? "No name",
                                style: AppStyles.searchResultStyle),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchResult.remove(searchResult[index]);
                                  });
                                },
                                icon: SvgPicture.asset(AppAssets.icClose,
                                    height: 10,
                                    color: AppColors.primaryMainColor
                                        .withOpacity(0.5))),
                          ],
                        ),
                      );
                    }),
              )
      ],
    )));
  }

  Future<void> search(String keyword) async {
    setState(() {
      searchResult.clear();
    });
    final snapshot = await usersRef.get();
    snapshot.docs.forEach((doc) {
      if ((doc.data() as Map<String, dynamic>)['fullName']
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase().trim())) {
        setState(() {
          searchResult.add(Users.fromJson(doc.data() as Map<String, dynamic>));
        });
      }
    });
  }
}
