import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/style.dart';

import '../../../data_models/user.dart';
import '../../../view_models/profile_view_model.dart';

class ProfileRecords extends StatelessWidget {
  const ProfileRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    return Row(
      children: <Widget>[
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowers(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return _userRecordsWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: "フォロワー",
              mode: "followers",
            );
          },
        ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowings(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return _userRecordsWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: "フォロー中",
              mode: "followings",
            );
          },
        )
      ],
    );
  }

  _userRecordsWidget({
    required BuildContext context,
    required int score,
    required String title,
    String? mode,
  }) {
    //タッチを検出したいWidgetの親WidgetにGestureDetectorを利用
    return GestureDetector(
      onTap: mode == null ? null : () => _checkFollowUsers(context, mode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: <Widget>[
          Text(score.toString(), style: profileRecordScoreTextStyle),
          Text(title.toString(), style: profileRecordTitleTextStyle),
        ]),
      ),
    );
  }

  _checkFollowUsers(BuildContext context, String mode) {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    //画面遷移 followScreenへ
    context.push("/profile/${profileUser.userId}/$mode");
  }
}
