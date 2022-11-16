import "package:flutter/material.dart";

class ProfileRecords extends StatelessWidget {
  const ProfileRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _userRecordsWidget(context: context, score: 0, title: "フォロー中"),
        _userRecordsWidget(context: context, score: 0, title: "フォロワー"),
      ],
    );
  }

  _userRecordsWidget(
      {required BuildContext context,
      required int score,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: <Widget>[
        Text(score.toString()),
        Text(title.toString()),
      ]),
    );
  }
}
