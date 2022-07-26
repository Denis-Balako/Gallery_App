import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListItem extends StatelessWidget {
  final String author;
  final Image avatar;
  final bool showImg;

  const ListItem({
    Key? key,
    required this.author,
    required this.avatar,
    required this.showImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      // margin: const EdgeInsets.symmetric(
      //   vertical: 8,
      //   horizontal: 5,
      // ),
      margin: const EdgeInsets.all(7),
      child: ListTile(
        leading: !showImg
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const CircleAvatar(
                  radius: 10.0,
                ),
              )
            : CircleAvatar(
                backgroundImage: avatar.image,
                backgroundColor: Colors.white,
              ),
        title: Text(
          author,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
