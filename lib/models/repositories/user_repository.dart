import 'dart:io';

import 'package:uuid/uuid.dart';

import '../../data_models/user.dart';
import '../../utils/extensions.dart';
import '../db/database_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fluttertoast/fluttertoast.dart';

class UserRepository {
  final DatabaseManager dbManager;
  UserRepository({required this.dbManager});
  //サインイン処理をして、サインインされたユーザーを db に登録して、
  //登録されたらユーザーを static 変数に入れる
  static User? currentUser;
  // To create a new Firebase Auth instance, call the instance getter on FirebaseAuth:
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //サインインしているかどうかの判定
  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final firebaseUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (firebaseUser == null) return false;
      //ユーザーが存在するか確認
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } on auth.FirebaseAuthException catch (e) {
      var message = FirebaseAuthErrorExt.fromCode(e.code).message;
      Fluttertoast.showToast(msg: message);
      return false;
    }
    // catch (error) {
    //   Fluttertoast.showToast(msg: error.toString());
    //   return false;
    // }
  }

  //サインアップ
  Future<bool> signUp(String name, String email, String password) async {
    try {
      //Register
      final firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (firebaseUser == null) return false;
      //Firestoreに保存
      await dbManager
          .insertUser(_convertToFirebaseUser(firebaseUser, name, email));
      return true;
    } on auth.FirebaseAuthException catch (e) {
      var message = FirebaseAuthErrorExt.fromCode(e.code).message;
      Fluttertoast.showToast(msg: message);
      return false;
    }
    // catch (error) {
    //   Fluttertoast.showToast(msg: error.toString());
    //   return false;
    // }
  }

  //上記のデータをUser型に変換
  _convertToFirebaseUser(auth.User firebaseUser, String name, String email) {
    return User(
      userId: firebaseUser.uid,
      displayName: name,
      appUserName: name,
      photoUrl: firebaseUser.photoURL ?? "",
      email: email,
      bio: "",
    );
  }

  //サインアウト
  Future<void> signOut() async {
    await _auth.signOut();
    currentUser = null;
  }

  Future<void> getCurrentUserById(String userId) async {
    currentUser = await dbManager.getUserInfoFromDbById(userId);
  }

  Future<User> getUserById(String userId) async {
    return await dbManager.getUserInfoFromDbById(userId);
  }

  Future<void> changeEmail(
    String emailUpdated,
    String password,
    User currentUser,
  ) async {
    try {
      //This operation is sensitive and requires recent authentication.
      //Log in again before retrying this request.
      await _auth.signInWithEmailAndPassword(
        email: currentUser.email,
        password: password,
      );
      //authenticationの方の更新
      await _auth.currentUser!.updateEmail(emailUpdated);
      //Firestoreに保存
      final userBeforeUpdate =
          await dbManager.getUserInfoFromDbById(currentUser.userId);
      final updateUser = userBeforeUpdate.copyWith(email: emailUpdated);
      await dbManager.updateProfile(updateUser);
      Fluttertoast.showToast(msg: "メールアドレスが更新されました");
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  //TODO パスワード変更処理
  Future<void> changePassword(String email, User currentUser) async {
    try {
      //パスワード変更メール
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "パスワード変更メールが送信されました");
      //Firestoreに保存
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  //プロフィールの更新
  Future<void> updateProfile(
    User profileUser,
    String nameUpdated,
    String bioUpdated,
    String photoUrlUpdated,
    bool isImageFromFile,
  ) async {
    var updatePhotoUrl;
    if (isImageFromFile) {
      final updatePhotoFile = File(photoUrlUpdated);
      final storagePath = const Uuid().v1();
      updatePhotoUrl =
          await dbManager.uploadImageToStorage(updatePhotoFile, storagePath);
    }
    final userBeforeUpdate =
        await dbManager.getUserInfoFromDbById(profileUser.userId);
    final updateUser = userBeforeUpdate.copyWith(
      appUserName: nameUpdated,
      photoUrl: isImageFromFile ? updatePhotoUrl : userBeforeUpdate.photoUrl,
      bio: bioUpdated,
    );
    await dbManager.updateProfile(updateUser);
  }

  Future<int> getNumberOfFollowers(User profileUser) async {
    return (await dbManager.getFollowerUserIds(profileUser.userId)).length;
  }

  Future<int> getNumberOfFollowings(User profileUser) async {
    return (await dbManager.getFollowingUserIds(profileUser.userId)).length;
  }

  Future<void> follow(User profileUser) async {
    if (currentUser != null) {
      await dbManager.follow(profileUser, currentUser!);
    }
  }

  Future<void> unfollow(User profileUser) async {
    if (currentUser != null) {
      await dbManager.unfollow(profileUser, currentUser!);
    }
  }

  Future<List<User>> getFollowUsers(String id, String mode) async {
    var results = <User>[];
    switch (mode) {
      case "followers":
        results = await dbManager.getFollowerUsers(id);
        break;
      case "followings":
        results = await dbManager.getFollowingUsers(id);
        break;
    }
    return results;
  }
}
