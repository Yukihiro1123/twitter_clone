import "package:flutter/material.dart";
import 'package:twitter_clone/style.dart';

import 'circle_photo.dart';

class UserCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String photoUrl;
  final Widget? trailing;
  final VoidCallback? onTap;
  const UserCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.photoUrl,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: onTap,
      child: ListTile(
        leading: CirclePhoto(photoUrl: photoUrl),
        title: Text(title, style: userCardTitleTextStyle),
        subtitle: Text(subTitle, style: userCardSubTitleTextStyle),
        trailing: trailing,
      ),
    );
  }
}
