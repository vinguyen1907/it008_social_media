// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/fullscreen_story/widgets/instruction.dart';
import 'package:it008_social_media/fullscreen_story/widgets/tile.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/utils/global_methods.dart';
import 'package:path/path.dart';

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
    totalCurrentIndex = widget.initialPage;

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
              return fullScreenStoryItem(
                  size, context, widget.stories[totalCurrentIndex]);
            })),
      ),
    );
  }

  GestureDetector fullScreenStoryItem(
      Size size, BuildContext context, List<Story> storyGroup) {
    print("Length: ${storyGroup.length}");
    print("Current: $currentIndex");
    print(storyGroup[currentIndex].toJson());

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
                            imageUrl: storyGroup[index].imageUrl,
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
                    StoryInstruction(
                        currentIndex: currentIndex,
                        groupLength: storyGroup.length,
                        size: size)
                  ],
                ),
              ),
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

              StoryTile(
                  imageUrl: storyGroup.first.userAvatarUrl,
                  name: storyGroup.first.userName,
                  time: GlobalMethods.getPeriodTimeToNow(
                      storyGroup[0].createdTime.toDate()))
            ],
          ),
        ],
      ),
    );
  }
}
