import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/profile/my_profile_page.dart';
import 'package:it008_social_media/screens/profile/profile_page.dart';
import 'package:it008_social_media/widgets/search_bar_widget.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:provider/provider.dart';

import '../../change_notifies/user_provider.dart';

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
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          Hero(
            tag: 'search_bar',
            child: Material(
              type: MaterialType.transparency,
              child: Container(
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
            ),
          ),
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
                          child: GestureDetector(
                            onTap: () {
                              if (searchResult[index].id ==
                                  userProvider.getUser?.id) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MyProfilePage(
                                        uid: userProvider.getUser?.id ?? ""),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProfilePage(
                                      uid: searchResult[index].id ?? "",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                ClipOval(
                                  child: searchResult[index].avatarImageUrl !=
                                              null &&
                                          searchResult[index].avatarImageUrl !=
                                              ""
                                      ? CachedNetworkImage(
                                          imageUrl: searchResult[index]
                                              .avatarImageUrl!,
                                          placeholder: (context, url) =>
                                              Container(
                                                  color: Colors.grey[200]),
                                          // errorWidget: (context, url, error) {
                                          //   return Container(
                                          //       color: Colors.grey[200],
                                          //       child: Image.asset(
                                          //           AppAssets.defaultImage));
                                          //   // return Container(color: Colors.red);
                                          // },
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: Colors.grey[200],
                                          child: Image.asset(
                                            AppAssets.defaultImage,
                                            width: 40,
                                            height: 40,
                                          )),
                                ),
                                const SizedBox(width: 10),
                                Text(searchResult[index].fullName ?? "No name",
                                    style: AppStyles.searchResultStyle),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        searchResult
                                            .remove(searchResult[index]);
                                      });
                                    },
                                    icon: SvgPicture.asset(AppAssets.icClose,
                                        height: 10,
                                        color: AppColors.primaryMainColor
                                            .withOpacity(0.5))),
                              ],
                            ),
                          ),
                        );
                      }),
                )
        ],
      ))),
    );
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
