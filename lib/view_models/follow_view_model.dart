import "package:flutter/material.dart";

import '../data_models/user.dart';
import '../models/repositories/user_repository.dart';

class FollowViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  //final WhoCaresMeMode mode;
  FollowViewModel({required this.userRepository});

  List<User> followUser = [];
  User get currentUser => UserRepository.currentUser!;

  Future<void> getFollowUsers(String id, String mode) async {
    //repositoryでmodeの場合分けを行う
    followUser = await userRepository.getFollowUsers(id, mode);
    notifyListeners();
  }
  // void rebuildAfterPop(String popProfileUserId) {
  //   getCaresMeUsers(popProfileUserId, whoCaresMeMode);

  // }
}
