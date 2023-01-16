import 'package:flutter/material.dart';

class SearchBackgound extends StatelessWidget {
  final bool isSearching;

  const SearchBackgound({Key? key, required this.isSearching}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSearching
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.9),
          )
        : Container();
  }
}
