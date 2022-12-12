import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/notification_type.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/notification_screen/widgets/notification_widget.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/utils/global_methods.dart';
import 'package:it008_social_media/widgets/status_tile_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static const id = 'notification_screen';

  @override
  Widget build(BuildContext context) {
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
            child: Column(
          children: [
            SingleChildScrollView(
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
                        .doc(user!.uid)
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

                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          final NotificationModel notification =
                              NotificationModel.fromJson(data);
                          final String description =
                              (notification.notificationType ==
                                      NotificationType.comment.toString()
                                  ? " commented on your post"
                                  : notification.notificationType ==
                                          NotificationType.like.toString()
                                      ? " liked your post"
                                      : " followed you");

                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) {
                                    notificationsRef
                                        .doc(user!.uid)
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
                              onTap: () {
                                if (notification.notificationType ==
                                        NotificationType.comment.toString() ||
                                    notification.notificationType ==
                                        NotificationType.like.toString()) {
                                  postsRef.doc(notification.postId).get().then(
                                      (post) => Navigator.of(context).pushNamed(
                                          CommentScreen.id,
                                          arguments: Post.fromJson(post.data()
                                              as Map<String, dynamic>)));
                                }
                                // TODO: Handle following situation
                              },
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
            )),
          ],
        )));
  }
}
