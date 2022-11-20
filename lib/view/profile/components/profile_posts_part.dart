import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view_models/profile_view_model.dart';
import '../../../data_models/post.dart';
import '../../../data_models/user.dart';
import '../../../style.dart';
import '../../../utils/constants.dart';

import '../../common/user_card.dart';
import 'profile_likes_part.dart';

class ProfilePostsPart extends StatelessWidget {
  final Post post;
  final FeedMode feedMode;
  const ProfilePostsPart(
      {super.key, required this.post, required this.feedMode});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    return FutureBuilder(
      future: profileViewModel.getPostUserInfo(post.userId),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final postUser = snapshot.data!;
          final currentUser = profileViewModel.currentUser;
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UserCard(
                  title: postUser.appUserName,
                  subTitle:
                      DateFormat("yyyy-MM-dd-HH:mm").format(post.postDateTime),
                  photoUrl: postUser.photoUrl,
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (PostMenu value) =>
                        _onPopupMenuSelected(context, value),
                    itemBuilder: (BuildContext context) {
                      if (postUser.userId == currentUser.userId) {
                        return [
                          const PopupMenuItem(
                            value: PostMenu.EDIT,
                            child: Text("編集"),
                          ),
                          const PopupMenuItem(
                            value: PostMenu.DELETE,
                            child: Text("削除"),
                          ),
                          const PopupMenuItem(
                            value: PostMenu.SHARE,
                            child: Text("シェア"),
                          ),
                        ];
                      } else {
                        return [
                          const PopupMenuItem(
                            value: PostMenu.SHARE,
                            child: Text("シェア"),
                          ),
                        ];
                      }
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
                      ProfileLikesPart(postUser: postUser, post: post),
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

  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch (selectedMenu) {
      case PostMenu.EDIT:
        break;
      //シェア
      case PostMenu.SHARE:
        break;
      case PostMenu.DELETE:
        _deletePost(context, post);
      // showConfirmDialog(
      //   context: context,
      //   title: "投稿の削除",
      //   content: "本当に削除しても良いですか",
      //   onConfirmed: (isConfirmed) {
      //     _deletePost(context, post);
      //   },
      // );
    }
  }

  void _deletePost(BuildContext context, Post post) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.deletePost(post, feedMode);
  }
}
