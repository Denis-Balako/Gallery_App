import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black87,
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: Image(image: NetworkImage(imagePath)),
            ),
          ),
        ),
      ),
    );
  }
}
