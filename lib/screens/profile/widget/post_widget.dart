import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/profile/widget/post_image_card.dart';
import 'package:provider/provider.dart';

import '../../../change_notifies/user_provider.dart';

class PostWidget extends StatelessWidget {
  final String uid;
  const PostWidget({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 7),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('userId', isEqualTo: uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                //mainAxisExtent: 99,
              ),
              shrinkWrap: true,
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (BuildContext context, int index) {
                return PostImageCard(
                  snap: snapshot.data!.docs[index].data(),
                );
              },
            );
          }),
    );
  }
}
