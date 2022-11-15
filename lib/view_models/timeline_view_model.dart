import 'package:flutter/material.dart';

import '../data_models/like.dart';
import '../data_models/post.dart';
import '../data_models/user.dart';
import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class TimelineViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  TimelineViewModel({
    required this.userRepository,
    required this.postRepository,
  });

  bool isProcessing = false;
  List<Post>? posts = [];
  late User feedUser;
  User get currentUser => UserRepository.currentUser!;

  Future<void> getPosts() async {
    isProcessing = true;
    notifyListeners();
    posts = await postRepository.getPosts();
    isProcessing = false;
    notifyListeners();
  }

  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }

  Future<LikeResult> getLikeResult(postId) async {
    return await postRepository.getLikeResult(postId, currentUser);
  }

  Future<void> likeIt(Post post) async {
    await postRepository.likeIt(post, currentUser);
    notifyListeners();
  }

  Future<void> unlikeIt(Post post) async {}
}
