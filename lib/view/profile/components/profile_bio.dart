import "package:flutter/material.dart";
import '../../../data_models/user.dart';

class ProfileBio extends StatelessWidget {
  final User profileUser;
  const ProfileBio({super.key, required this.profileUser});

  @override
  Widget build(BuildContext context) {
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
