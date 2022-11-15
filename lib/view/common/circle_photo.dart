import "package:flutter/material.dart";

class CirclePhoto extends StatelessWidget {
  final String? photoUrl;
  final double? radius;
  const CirclePhoto({super.key, this.photoUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
    );
  }
}
