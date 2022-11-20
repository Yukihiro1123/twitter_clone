import 'package:flutter/material.dart';
import 'package:twitter_clone/models/repositories/post_repository.dart';
import '../data_models/like.dart';
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
  bool isSuccessful = false;
  bool isFollowingProfileUser = false;
  List<Post>? posts = [];
  List<Post>? likePosts = [];

  late User profileUser;
  //Getterを利用し、UserRepositoryクラスの変数を参照のみ可能とする
  User get currentUser => UserRepository.currentUser!;

  void setProfileUser(selectedUser) async {
    //TODO 他者のページの場合と自分のページの場合の場合分け
    if (selectedUser != null) {
      isProcessing = true;
      profileUser = selectedUser!;
      notifyListeners();
      isProcessing = false;
      notifyListeners();
    } else {
      profileUser = currentUser;
    }
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

  deletePost(Post post, FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();
    await postRepository.deletePost(post.postId);
    await getPosts();
    await getLikePosts();
    isProcessing = false;
    notifyListeners();
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
    //String? emailUpdated,
    //String? passwordUpdated,
  ) async {
    isProcessing = true;
    notifyListeners();
    await userRepository.updateProfile(
      profileUser,
      nameUpdated,
      bioUpdated,
      photoUrlUpdated,
      isImageFromFile,
    );
    //ここまで行うと、タイムラインでは変更が反映されるが、プロフィールページはそうではない
    //変更後にユーザーデータを再取得してstaticに保存
    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;
    isProcessing = false;
    notifyListeners();
  }

  changeEmail(String emailUpdated, String password) async {
    isProcessing = true;
    notifyListeners();
    await userRepository.changeEmail(emailUpdated, password, currentUser);
    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;
    isProcessing = false;
    notifyListeners();
  }

  changePassword(String email) async {
    isProcessing = true;
    notifyListeners();
    await userRepository.changePassword(email, currentUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<int> getNumberOfFollowers() async {
    return await userRepository.getNumberOfFollowers(profileUser);
  }

  Future<int> getNumberOfFollowings() async {
    return await userRepository.getNumberOfFollowings(profileUser);
  }

  Future<void> follow() async {
    await userRepository.follow(profileUser);
    isFollowingProfileUser = true;
    notifyListeners();
  }

  Future<void> unfollow() async {
    await userRepository.unfollow(profileUser);
    isFollowingProfileUser = false;
    notifyListeners();
  }

  Future<LikeResult> getLikeResult(String postId) async {
    return await postRepository.getLikeResult(postId, currentUser);
  }

  Future<void> likeIt(Post post) async {
    await postRepository.likeIt(post, currentUser);
    notifyListeners();
  }

  Future<void> unlikeIt(Post post) async {
    await postRepository.unLikeIt(post, currentUser);
    notifyListeners();
  }
}
