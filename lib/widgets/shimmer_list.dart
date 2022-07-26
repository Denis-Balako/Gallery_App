import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final VoidCallback handler;

  const ShimmerList({
    Key? key,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handler();
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        // separatorBuilder: (BuildContext context, int index) => const Divider(
        //   color: Colors.black54,
        // ),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                width: 48.0,
                height: 48.0,
                // color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 18.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
