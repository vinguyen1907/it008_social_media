import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/screens/add_post/add_post_page.dart';
import 'package:it008_social_media/screens/chat/chat_page.dart';
import 'package:it008_social_media/screens/home_screen/home_screen.dart';
import 'package:it008_social_media/screens/podcast_page/podcast_page.dart';
import 'package:provider/provider.dart';

import '../profile/my_profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  loadUserData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();

    // setState(() {
    //   isLoading = false;
    // });
  }

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    // Scaffold(),
    HomeScreen(),
    AddPostPage(),
    PodcastPage(),
    ChatPage(),
    MyProfilePage(uid: FirebaseAuth.instance.currentUser!.uid.toString()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).getUser == null
        ? const Scaffold(
            body: Center(
                child: SpinKitSquareCircle(color: AppColors.primaryMainColor)))
        : Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                _onItemTapped(index);
              },
              children: _widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: const IconThemeData(color: Colors.blueAccent),
              unselectedItemColor: Colors.amber,
              showSelectedLabels: false, // <-- HERE
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: AppColors.primaryTextColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/ic_active_home.svg',
                    // color: AppColors.primaryTextColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_add.svg',
                    color: AppColors.primaryTextColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/ic_active_add.svg',
                    // color: AppColors.primaryTextColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppAssets.icVoice,
                      color: AppColors.primaryTextColor, height: 25),
                  activeIcon:
                      SvgPicture.asset(AppAssets.icActiveVoice, height: 25),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_chat.svg',
                    color: AppColors.primaryTextColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/ic_active_chat.svg',
                    // color: AppColors.primaryTextColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/personal.svg',
                    color: AppColors.primaryTextColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/ic_active_profile.svg',
                    // color: AppColors.primaryTextColor,
                  ),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
  }
}
