import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarding1.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarding2.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarding3.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up.dart';

class OnBoardingScroll extends StatefulWidget {
  const OnBoardingScroll({super.key});

  @override
  State<OnBoardingScroll> createState() => _OnBoardingScrollState();
}

class _OnBoardingScrollState extends State<OnBoardingScroll> {
  final PageController _pageViewController = PageController(initialPage: 0); // set the initial page you want to show
  int _activePage = 0;  // will hold current active page index value
  //Create a List Holding all the Pages
  final List<Widget> _Pages = [
    OnBoarding1(),
    OnBoarding2(),
    OnBoarding3()
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageViewController.dispose();  // dispose the PageController
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // will make use of Stack Widget, so that One Widget can we placed on top
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageViewController,
            onPageChanged: (int index){
              setState(() {
                _activePage = index;
              });
            },
            itemCount: _Pages.length,
              itemBuilder: (BuildContext context, int index){
                return _Pages[index];
              }
          ),
          //creating dots at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 40,
              child: Container(
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      _Pages.length,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            _pageViewController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: CircleAvatar(
                            radius: 5,
                            // check if a dot is connected to the current page
                            // if true, give it a different color
                            backgroundColor: _activePage == index
                                ? Color(0xff006175)
                                : Colors.white30,
                          ),
                        ),
                      )),
                ),
              ),
          ),
        ],
      ),
    );
  }
}