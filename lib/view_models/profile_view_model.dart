import 'package:flutter/material.dart';
import '../data_models/user.dart';
import '../models/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  ProfileViewModel({required this.userRepository});
  late User profileUser;
  //Getterを利用し、UserRepositoryクラスの変数を参照のみ可能とする
  User get currentUser => UserRepository.currentUser!;

  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }
}
