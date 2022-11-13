import 'package:flutter/material.dart';

import '../models/repositories/user_repository.dart';

// ChangeNotifier
// クラスの中で依存する対象のインスタンスを作るのではなく、
// 外で作ったものをコンストラクタから注入
class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({required this.userRepository});
  bool isLoading = false;
  bool isSuccessful = false;

  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();
    isSuccessful = await userRepository.signIn(email, password);
    isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();
    isSuccessful = await userRepository.signUp(name, email, password);
    isLoading = false;
    notifyListeners();
  }
}
