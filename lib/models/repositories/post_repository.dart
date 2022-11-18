import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:uuid/uuid.dart';

import '../../data_models/like.dart';
import '../../data_models/post.dart';
import '../../utils/constants.dart';
import '../db/database_manager.dart';

class PostRepository {
  final DatabaseManager dbManager;
  PostRepository({required this.dbManager});

  Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print("The path is ${pickedImage?.path}");
    return (pickedImage != null) ? File(pickedImage.path) : null;
  }

  Future<void> post(User currentUser, String tweetText) async {
    final storageId = const Uuid().v1();
    final post = Post(
      postId: storageId,
      userId: currentUser.userId,
      tweetText: tweetText,
      postDateTime: DateTime.now(),
    );
    await dbManager.insertPost(post);
  }

  Future<List<Post>> getPosts(FeedMode feedMode, User? feedUser) async {
    if (feedMode == FeedMode.likes) {
      //いいね
      return dbManager.getLikePosts(feedUser!.userId);
    } else if (feedMode == FeedMode.profile) {
      return dbManager.getPostsByUser(feedUser!.userId);
    } else {
      return dbManager.getPosts();
    }
  }

  Future<void> likeIt(Post post, User currentUser) async {
    final like = Like(
      likeUserId: currentUser.userId,
      likeId: const Uuid().v1(),
      postId: post.postId,
      likeDateTime: DateTime.now(),
    );
    await dbManager.likeIt(like);
  }

  Future<void> unLikeIt(Post post, User currentUser) async {
    await dbManager.unLikeIt(post, currentUser);
  }

  Future<LikeResult> getLikeResult(String postId, User currentUser) async {
    //いいねの取得
    final likes = await dbManager.getLikes(postId);
    //自分がその投稿にいいねしたかどうかの判定
    var isLikePost = false;
    for (var like in likes) {
      if (like.likeUserId == currentUser.userId) {
        isLikePost = true;
        break;
      }
    }
    return LikeResult(likes: likes, isLikeToThisPost: isLikePost);
  }
}
