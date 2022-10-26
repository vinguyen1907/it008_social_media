import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24,top: 7),
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
              "https://scontent.fsgn8-4.fna.fbcdn.net/v/t39.30808-6/312576837_481329224039824_1971902793594846384_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=730e14&_nc_ohc=wBUYKw46M3YAX_pOyT7&_nc_ht=scontent.fsgn8-4.fna&oh=00_AT9lDJ_i0zv-RyzB9gFVUG8WjKA-vzN2SDUkxHkiA7s_Vg&oe=635C103E",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
