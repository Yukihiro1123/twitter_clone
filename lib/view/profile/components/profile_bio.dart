import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../view_models/profile_view_model.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profileUser.appUserName),
          const SizedBox(height: 10),
          Text(profileUser.bio),
        ],
      ),
    );
  }
}
