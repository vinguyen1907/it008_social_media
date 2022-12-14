import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/comment_model.dart';
import 'package:it008_social_media/models/enum/notification_type.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/comment_screen/comment_widget.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/input_and_send.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.post}) : super(key: key);

  static const id = 'comment_screen';
  final Post post;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comment> comments = [];
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

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
            "Comment",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostWidget(
                    post: widget.post,
                    isActive: false,
                  ),
                  const SizedBox(height: 10),

                  // input comment
                  Container(
                    height: size.height * 0.05,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalMargin),
                    child: Row(children: [
                      ClipOval(
                          child: userProvider.getUser!.avatarImageUrl != ""
                              ? CachedNetworkImage(
                                  imageUrl:
                                      userProvider.getUser!.avatarImageUrl!,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                        color: Colors.grey[200],
                                        child: Icon(Icons.error));
                                  },
                                  height: size.height * 0.05,
                                )
                              : Image.asset(AppAssets.defaultImage,
                                  fit: BoxFit.cover,
                                  height: size.height * 0.05)),
                      const SizedBox(width: 10),
                      InputAndSendWidget(
                        size: size,
                        hintText: "Add a comment...",
                        borderColor: const Color(0xff4D4D4D),
                        hintColor: const Color(0xffcccccc),
                        textColor: Colors.black,
                        controller: controller,
                        onPressed: () {
                          _handleComment(userProvider);
                        },
                      ),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.defaultHorizontalMargin,
                        top: Dimensions.smallVerticalMargin),
                    child: Text('Comments',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ),
                  FutureBuilder<Object>(
                      future: postsRef
                          .doc(widget.post.id)
                          .collection('comments')
                          .orderBy('createdTime', descending: true)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot querySnapshot =
                              snapshot.data as QuerySnapshot;
                          if (querySnapshot.docs.isEmpty) {
                            return SizedBox(
                              width: size.width,
                              child: Text(
                                "No comments found",
                                style: AppStyles.noItemText,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          comments = querySnapshot.docs
                              .map((doc) => Comment.fromJson(
                                  doc.data() as Map<String, dynamic>))
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                Comment comment = comments[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.defaultHorizontalMargin,
                                      vertical: Dimensions.smallVerticalMargin),
                                  child: CommentWidget(
                                    comment: comment,
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return const Text("Error");
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })
                ],
              )),
            ),
          ],
        )));
  }

  void _handleComment(UserProvider userProvider) {
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    // push comment to Firebase
    if (controller.text != "") {
      final doc = postsRef.doc(widget.post.id).collection('comments').doc();
      Comment comment = Comment(
        id: doc.id,
        content: controller.text,
        userId: userProvider.getUser!.id ?? "No user",
        userName: userProvider.getUser!.fullName ?? "No name",
        userAvatarUrl: userProvider.getUser!.avatarImageUrl ?? "",
        createdTime: Timestamp.now(),
      );
      setState(() {
        comments.insert(0, comment);
      });
      postsRef
          .doc(widget.post.id)
          .collection('comments')
          .doc(doc.id)
          .set(comment.toJson());
      controller.clear();
    }

    // add notification if it is not own post
    if (user.id != widget.post.userId) {
      final notiDoc = notificationsRef
          .doc(widget.post.userId)
          .collection('notifications')
          .doc();
      NotificationModel notification = NotificationModel(
        id: notiDoc.id,
        fromUserId: userProvider.getUser!.id!,
        fromUserName: userProvider.getUser!.fullName!,
        fromUserAvatarUrl: userProvider.getUser!.avatarImageUrl!,
        toUserId: widget.post.userId,
        notificationType: NotificationType.comment.toString(),
        postId: widget.post.id,
        createdTime: Timestamp.now(),
      );
      notiDoc.set(notification.toJson());
    }

    // dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
