import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/notification_type.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/notification_screen/widgets/notification_widget.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/utils/global_methods.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static const id = 'notification_screen';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Users user = Provider.of<UserProvider>(context).getUser!;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Notifications",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Dimensions.defaultHorizontalMargin,
            //       vertical: 15),
            //   child: Text('Today',
            //       textAlign: TextAlign.start,
            //       style: TextStyle(
            //           fontFamily: 'Poppins',
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500)),
            // ),
            StreamBuilder<QuerySnapshot>(
                stream: notificationsRef
                    .doc(user.id)
                    .collection('notifications')
                    .orderBy('createdTime', descending: true)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitThreeBounce(
                        color: AppColors.primaryMainColor);
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height / 5),
                          SvgPicture.asset(AppAssets.emptyNotification,
                              height: size.height / 4),
                          SizedBox(height: size.height * 0.02),
                          const Text("No notifications yet.",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          const Text(
                              "When you get notifications, they'll show up here.",
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14)),
                        ],
                      ),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      final NotificationModel notification =
                          NotificationModel.fromJson(data);

                      String description = _getDescription(notification);

                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 1,
                              onPressed: (context) {
                                notificationsRef
                                    .doc(user.id)
                                    .collection('notifications')
                                    .doc(document.id)
                                    .delete();
                              },
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              _onNotificationTap(notification, context),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.only(
                                bottom: 20,
                                left: Dimensions.defaultHorizontalMargin,
                                right: Dimensions.defaultHorizontalMargin),
                            child: NotificationWidget(
                                name: notification.fromUserName,
                                actionDescription: description,
                                subtitle: GlobalMethods.getPeriodTimeToNow(
                                    notification.createdTime.toDate()),
                                backgroundImageUrl:
                                    notification.fromUserAvatarUrl),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                })),
          ],
        ))));
  }

  _onNotificationTap(NotificationModel notification, BuildContext context) {
    if (notification.notificationType == NotificationType.comment.toString() ||
        notification.notificationType == NotificationType.like.toString() ||
        notification.notificationType == NotificationType.addPost.toString()) {
      postsRef.doc(notification.postId).get().then((post) =>
          Navigator.of(context).pushNamed(CommentScreen.id,
              arguments: Post.fromJson(post.data() as Map<String, dynamic>)));
    }
    // TODO: Handle following situation
  }

  String _getDescription(NotificationModel notification) {
    if (notification.notificationType == NotificationType.comment.toString()) {
      return " commented on your post";
    } else if (notification.notificationType ==
        NotificationType.like.toString()) {
      return " liked your post";
    } else if (notification.notificationType ==
        NotificationType.addPost.toString()) {
      return " added a new post";
    } else if (notification.notificationType ==
        NotificationType.follow.toString()) {
      return " followed you";
    } else {
      return "";
    }
  }
}
