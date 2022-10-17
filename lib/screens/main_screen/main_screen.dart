import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/screens/home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
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
            icon: SvgPicture.asset("assets/icons/home.svg"),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_home.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/ic_add.svg'),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_add.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/ic_chat.svg'),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_chat.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/personal.svg'),
            activeIcon: SvgPicture.asset('assets/icons/ic_active_profile.svg'),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
