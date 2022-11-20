import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/view_models/follow_view_model.dart';

import '../common/user_card.dart';

class FollowScreen extends StatelessWidget {
  final String id;
  final String mode;
  const FollowScreen({super.key, required this.id, required this.mode});

  @override
  Widget build(BuildContext context) {
    final followViewModel = context.read<FollowViewModel>();
    Future(() => followViewModel.getFollowUsers(id, mode));
    return Scaffold(
      appBar: AppBar(title: Text(_titleText(context, mode))),
      body: Consumer<FollowViewModel>(
        builder: (_, model, child) {
          return model.followUser.isEmpty
              ? Container(child: Text("No $mode yet."))
              : ListView.builder(
                  itemCount: model.followUser.length,
                  itemBuilder: (context, int index) {
                    final user = model.followUser[index];
                    return UserCard(
                      photoUrl: user.photoUrl,
                      title: user.appUserName,
                      subTitle: user.bio,
                      onTap: () => _openProfileScreen(context, user),
                    );
                  },
                );
        },
      ),
    );
  }

  String _titleText(BuildContext context, String mode) {
    var titleText = "";
    switch (mode) {
      case "followings":
        titleText = "フォロー中";
        break;
      case "followers":
        titleText = "フォロワー";
        break;
    }
    return titleText;
  }

  _openProfileScreen(BuildContext context, User user) {
    //final followViewModel = context.read<FollowViewModel>();
    context.push("/profile/${user.userId}");
  }
}
