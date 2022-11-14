import 'package:flutter/material.dart';

import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  PostViewModel({required this.userRepository, required this.postRepository});
  bool isProcessing = false;
  String tweetText = "";

  Future<void> post() async {
    isProcessing = true;
    notifyListeners();
    await postRepository.post(
      UserRepository.currentUser!,
      tweetText,
    );
    isProcessing = false;
    notifyListeners();
  }
}
