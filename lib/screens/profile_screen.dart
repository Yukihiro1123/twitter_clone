import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/profile/profile_page.dart';

import '../data_models/user.dart';
import '../view_models/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    return FutureBuilder(
      future: profileViewModel.getPostUserInfo(userId),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        final profileUser = snapshot.data!;
        final currentUser = profileViewModel.currentUser;
        if (snapshot.hasData && snapshot.data != null) {
          return ProfilePage(
            selectedUser: profileUser,
            isOpenFromProfileScreen: true,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
