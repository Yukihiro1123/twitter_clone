import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data_models/user.dart';
import '../../utils/constants.dart';
import '../../view_models/like_view_model.dart';
import '../timeline/components/timeline_tile.dart';
import 'components/like_tile.dart';

class LikesPage extends StatelessWidget {
  final User? likeUser;
  const LikesPage({super.key, this.likeUser});

  @override
  Widget build(BuildContext context) {
    final likeViewModel = context.read<LikeViewModel>();
    likeViewModel.setLikeUser(likeUser);
    Future(() => likeViewModel.getPosts());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const FaIcon(
          FontAwesomeIcons.solidHeart,
          color: Colors.blue,
        ),
        centerTitle: true,
      ),
      body: Consumer<LikeViewModel>(builder: (context, model, child) {
        if (model.isProcessing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return (model.posts == null || model.posts!.isEmpty)
              ? const Center(child: Text('No Likes yet.'))
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: model.posts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LikeTile(
                      post: model.posts![index],
                      feedMode: FeedMode.likes,
                    );
                  },
                );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//