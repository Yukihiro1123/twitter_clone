import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../data_models/post.dart';
import '../../../data_models/user.dart';
import '../../../view_models/like_view_model.dart';

class LikesPart extends StatelessWidget {
  final Post post;
  final User postUser;
  const LikesPart({
    super.key,
    required this.post,
    required this.postUser,
  });

  @override
  Widget build(BuildContext context) {
    final likeViewModel = context.read<LikeViewModel>();
    return FutureBuilder(
      future: likeViewModel.getLikeResult(post.postId),
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
    final likeViewModel = context.read<LikeViewModel>();
    await likeViewModel.likeIt(post);
  }

  _unlikeIt(BuildContext context) async {
    final likeViewModel = context.read<LikeViewModel>();
    await likeViewModel.unlikeIt(post);
  }
}
