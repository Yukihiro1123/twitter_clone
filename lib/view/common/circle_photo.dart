import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class CirclePhoto extends StatelessWidget {
  final String photoUrl;
  final double? radius;
  const CirclePhoto({super.key, required this.photoUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: (photoUrl == "" || photoUrl.isEmpty)
          ? const NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/1946/1946429.png")
          : CachedNetworkImageProvider(photoUrl) as ImageProvider,
    );
  }
}
