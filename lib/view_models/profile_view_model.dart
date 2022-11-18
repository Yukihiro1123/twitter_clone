import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/post_repository.dart';
import '../data_models/post.dart';
import '../data_models/user.dart';
import '../models/repositories/user_repository.dart';
import '../utils/constants.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  ProfileViewModel({
    required this.userRepository,
    required this.postRepository,
  });

  bool isProcessing = false;
  List<Post>? posts = [];
  List<Post>? likePosts = [];

  late User profileUser;
  //Getterを利用し、UserRepositoryクラスの変数を参照のみ可能とする
  User get currentUser => UserRepository.currentUser!;

  void setProfileUser(User? selectedUser) {
    //TODO 他者のページの場合と自分のページの場合の場合分け
    profileUser = currentUser;
  }

  Future<void> getPosts() async {
    isProcessing = true;
    notifyListeners();
    posts = await postRepository.getPosts(FeedMode.profile, profileUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<void> getLikePosts() async {
    isProcessing = true;
    notifyListeners();
    likePosts = await postRepository.getPosts(FeedMode.likes, profileUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }

  Future<String> pickProfileImage() async {
    final pickedImage = await postRepository.pickImage();
    return (pickedImage != null) ? pickedImage.path : "";
  }

  Future<void> updateProfile(
    String nameUpdated,
    String bioUpdated,
    String photoUrlUpdated,
    bool isImageFromFile,
  ) async {
    isProcessing = true;
    notifyListeners();
    await userRepository.updateProfile(
        profileUser, nameUpdated, bioUpdated, photoUrlUpdated, isImageFromFile);
    //ここまで行うと、タイムラインでは変更が反映されるが、プロフィールページはそうではない
    //変更後にユーザーデータを再取得してstaticに保存
    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;
    isProcessing = false;
    notifyListeners();
  }
}
