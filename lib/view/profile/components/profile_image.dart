import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../view_models/profile_view_model.dart';
import '../../common/circle_photo.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    return CirclePhoto(photoUrl: profileUser.photoUrl, radius: 30);
  }
}
