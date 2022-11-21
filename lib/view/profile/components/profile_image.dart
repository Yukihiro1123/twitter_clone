import "package:flutter/material.dart";

import '../../../data_models/user.dart';
import '../../common/circle_photo.dart';

class ProfileImage extends StatelessWidget {
  final User profileUser;
  const ProfileImage({super.key, required this.profileUser});

  @override
  Widget build(BuildContext context) {
    return CirclePhoto(photoUrl: profileUser.photoUrl, radius: 30);
  }
}
