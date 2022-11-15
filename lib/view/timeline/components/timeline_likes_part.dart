import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../data_models/post.dart';
import '../../../data_models/user.dart';
import '../../../view_models/timeline_view_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimelineLikesPart extends StatelessWidget {
  final Post post;
  final User postUser;
  const TimelineLikesPart({
    super.key,
    required this.post,
    required this.postUser,
  });

  @override
  Widget build(BuildContext context) {
    final timelineViewModel = context.read<TimelineViewModel>();
    return FutureBuilder(
      future: timelineViewModel.getLikeResult(post.postId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final likeResult = snapshot.data!;
          return Row(
            children: <Widget>[
              likeResult.isLikeToThisPost
                  ? IconButton(
                      icon: const FaIcon(FontAwesomeIcons.solidHeart),
                      onPressed: () => _unlikeIt(context),
                    )
                  : IconButton(
                      icon: const FaIcon(FontAwesomeIcons.heart),
                      onPressed: () => _likeIt(context),
                    ),
              Text(likeResult.likes.length.toString()),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  _likeIt(BuildContext context) async {
    final timelineViewModel = context.read<TimelineViewModel>();
    await timelineViewModel.likeIt(post);
  }

  _unlikeIt(BuildContext context) async {}
}
