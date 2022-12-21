import 'package:flutter/material.dart';

import '../../../models/post_model.dart';
import '../../comment_screen/comment_screen.dart';

class PostImageCard extends StatelessWidget {
  final snap;
  const PostImageCard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       var posts = Post.fromJson(snap);
        Navigator.of(context)
            .pushNamed(CommentScreen.id, arguments: posts);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          (snap['imageUrl'] == "" || snap['imageUrl'] == null)
              ? "https://coolbackgrounds.io/images/backgrounds/white/pure-white-background-85a2a7fd.jpg"
              : snap['imageUrl'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
