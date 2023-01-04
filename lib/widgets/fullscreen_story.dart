// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/utils/global_methods.dart';

class FullScreenStory extends StatefulWidget {
  const FullScreenStory({
    Key? key,
    required this.stories,
    required this.initialPage,
  }) : super(key: key);

  final List<List<Story>> stories;
  final int initialPage;

  @override
  State<FullScreenStory> createState() => _FullScreenStoryState();
}

class _FullScreenStoryState extends State<FullScreenStory>
    with SingleTickerProviderStateMixin {
  final pageController = PageController();
  int currentIndex = 0;
  final TextEditingController messageTextController = TextEditingController();
  late AnimationController animationController;
  late Animation<double> nextPage;
  late PageController totalPageController;
  int totalCurrentIndex = 0;

  @override
  void initState() {
    super.initState();

    totalPageController = PageController(initialPage: widget.initialPage);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    nextPage = Tween(begin: 0.0, end: 1.0).animate(animationController);

    //Add listener to AnimationController for know when end the count and change to the next page
    animationController.addListener(() async {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reset(); //Reset the controller
        final int page = widget
            .stories[totalCurrentIndex].length; //Number of pages in PageView
        if (currentIndex < page - 1) {
          setState(() {
            currentIndex++;
          });
          await pageController.animateToPage(currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInSine);
        } else if (currentIndex == page - 1) {
          currentIndex = 0;
          if (totalCurrentIndex < widget.stories.length - 1) {
            setState(() {
              totalCurrentIndex++;
            });
            await totalPageController.animateToPage(totalCurrentIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInSine);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    messageTextController.dispose();
    totalPageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    animationController.forward();

    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: SafeArea(
        child: PageView(
            controller: totalPageController,
            onPageChanged: ((value) {
              setState(() {
                totalCurrentIndex = value;
                currentIndex = 0;
                if (animationController.isAnimating) {
                  animationController.reset();
                }
              });
              // animationController.forward();
            }),
            children: List.generate(widget.stories.length, (index) {
              return fullScreenStoryItem(size, context, widget.stories[index]);
            })),
      ),
    );
  }

  GestureDetector fullScreenStoryItem(
      Size size, BuildContext context, List<Story> storyGroup) {
    return GestureDetector(
      onTapDown: (details) async {
        final x = details.globalPosition.dx;
        if (x > size.width / 2) {
          await pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
        } else {
          await pageController.previousPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              // background
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: AppStyles.storyGradient,
                      ),
                      child: PageView.builder(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (newIndex) {
                          setState(() {
                            currentIndex = newIndex;
                          });
                        },
                        itemCount: storyGroup.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: storyGroup[index].imageUrl ?? "https://images.ctfassets.net/lh3zuq09vnm2/yBDals8aU8RWtb0xLnPkI/19b391bda8f43e16e64d40b55561e5cd/How_tracking_user_behavior_on_your_website_can_improve_customer_experience.png",
                            placeholder: ((context, url) => const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )),
                            fit: storyGroup[index].isFullScreen
                                ? BoxFit.cover
                                : BoxFit.contain,
                            // height: size.height * 0.6,
                            width: size.width,
                          ),
                        ),
                      ),
                    ),
                    _buildInstruction(size, widget.stories[totalCurrentIndex]),
                  ],
                ),
              ),

              // bottom bar
              // Container(
              //   width: size.width,
              //   height: size.height * 0.05,
              //   margin: const EdgeInsets.only(
              //     top: Dimensions.smallVerticalMargin,
              //     bottom: Dimensions.smallVerticalMargin,
              //   ),
              //   padding:
              //       const EdgeInsets.only(right: Dimensions.defaultMargin),
              //   child: Row(children: [
              //     IconButton(
              //       iconSize: 25,
              //       onPressed: () {},
              //       icon: SvgPicture.asset(
              //         AppAssets.icHeart,
              //         color: Colors.white,
              //         height: 25,
              //       ),
              //     ),
              //     InputAndSendWidget(
              //         size: size,
              //         hintText: "Send message",
              //         borderColor: Colors.white,
              //         hintColor: Colors.white,
              //         textColor: Colors.white,
              //         controller: messageTextController,
              //         onPressed: () {})
              //   ]),
              // )
            ],
          ),

          // header
          Column(
            children: [
              // timer bar
              Container(
                width: size.width,
                height: 25,
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalMargin),
                child: Row(
                  children: [
                    ...List.generate(storyGroup.length, (index) {
                      return Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: Dimensions.smallVerticalMargin),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                height: 2,
                                color: index == currentIndex
                                    ? AppColors.primaryMainColor
                                    : Colors.white.withOpacity(0.5))),
                      ));
                    }),
                  ],
                ),
              ),

              _buildTile(context, widget.stories[totalCurrentIndex])
            ],
          ),
        ],
      ),
    );
  }

  _buildTile(BuildContext context, List<Story> storyGroup) {
    // if (storyGroup.isEmpty) {
    //   return const CircularProgressIndicator();
    // }
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalMargin),
      child: Row(children: [
        ClipOval(
            child: storyGroup.first.userAvatarUrl != ""
                ? CachedNetworkImage(
                    imageUrl: storyGroup.first.userAvatarUrl,
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppAssets.defaultImage,
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                  )),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storyGroup.first.userName,
              style: AppStyles.postUserName.copyWith(
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3.0,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            Text(
              GlobalMethods.getPeriodTimeToNow(
                  storyGroup.first.createdTime.toDate()),
              style: AppStyles.postUploadTime.copyWith(
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3.0,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        // close button
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(0),
            icon: SvgPicture.asset(AppAssets.icClose, color: Colors.white))
      ]),
    );
  }

  Widget _buildInstruction(Size size, List<Story> storyGroup) {
    if (currentIndex == 0 && storyGroup.length > 1) {
      return Positioned(
          bottom: 10,
          child: Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppAssets.icTap,
                        height: 30, color: Colors.grey[200]),
                    const SizedBox(height: 5),
                    Text('Previous',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: 'Poppins',
                            fontSize: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(AppAssets.icTap,
                        height: 30, color: Colors.grey[200]),
                    const SizedBox(height: 5),
                    Text('Next',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontFamily: 'Poppins',
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ));
    } else if (currentIndex == storyGroup.length - 1) {
      return Positioned(
        bottom: 10,
        right: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(AppAssets.icSlideLeft,
                height: 30, color: Colors.grey[200]),
            const SizedBox(height: 5),
            Text('Slide left to next story',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontFamily: 'Poppins',
                    fontSize: 12)),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
