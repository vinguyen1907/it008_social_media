import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/screens/add_post/add_post_page.dart';
import 'package:it008_social_media/screens/chat/chat_page.dart';
import 'package:it008_social_media/screens/edit_profile/edit_prodfile_page.dart';
import 'package:it008_social_media/screens/home_screen/home_screen.dart';
import 'package:it008_social_media/screens/profile/profile_page.dart';

import '../profile/my_profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    HomeScreen(),
    AddPostPage(),
    ChatPage(),
    EditProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.blueAccent),
        unselectedItemColor: Colors.amber,
        showSelectedLabels: false, // <-- HERE
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg",color: AppColors.primaryTextColor,),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_home.svg',color: AppColors.primaryTextColor,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/ic_add.svg',color: AppColors.primaryTextColor,),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_add.svg',color: AppColors.primaryTextColor,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/ic_chat.svg',color: AppColors.primaryTextColor,),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_chat.svg',color: AppColors.primaryTextColor,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/personal.svg',color: AppColors.primaryTextColor,),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_profile.svg',color: AppColors.primaryTextColor,),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
