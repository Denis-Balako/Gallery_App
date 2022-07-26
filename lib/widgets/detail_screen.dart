import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Image image;

  const DetailScreen({
    super.key,
    required this.image,
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
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
