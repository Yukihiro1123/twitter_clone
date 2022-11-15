import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/style.dart';

import '../../../data_models/post.dart';
import '../../../data_models/user.dart';
import '../../../view_models/timeline_view_model.dart';
import '../../common/user_card.dart';
import 'timeline_likes_part.dart';

class TimelineTile extends StatelessWidget {
  final Post post;
  const TimelineTile({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final timelineViewModel = context.read<TimelineViewModel>();
    return FutureBuilder(
      future: timelineViewModel.getPostUserInfo(post.userId),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final postUser = snapshot.data!;
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UserCard(
                  onTap: () => print('Hi'),
                  title: postUser.appUserName,
                  subTitle:
                      DateFormat("yyyy-MM-dd-HH:mm").format(post.postDateTime),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          child: Text("編集"),
                        ),
                        const PopupMenuItem(
                          child: Text("削除"),
                        ),
                        const PopupMenuItem(
                          child: Text("シェア"),
                        ),
                      ];
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 75.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(post.tweetText, style: postCaptionTextStyle),
                      TimelineLikesPart(postUser: postUser, post: post),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
