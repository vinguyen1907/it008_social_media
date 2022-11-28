import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 7),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          //mainAxisExtent: 99,
        ),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/somedia-32434.appspot.com/o/story_image%2Fqlu8m5vUDRqjVpx4u8jD?alt=media&token=49f64034-2097-46d4-bff2-ef5458ffc8dd",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
