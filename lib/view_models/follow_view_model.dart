import "package:flutter/material.dart";

import '../data_models/user.dart';
import '../models/repositories/user_repository.dart';

class FollowViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  FollowViewModel({required this.userRepository});

  List<User> followUser = [];
  User get currentUser => UserRepository.currentUser!;

  Future<void> getFollowUsers(String id, String mode) async {
    //repositoryでmodeの場合分けを行う
    followUser = await userRepository.getFollowUsers(id, mode);
    notifyListeners();
  }
}
