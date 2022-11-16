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
      await dbManager.insertUser(
          _convertToFirebaseUser(firebaseUser, name, email, password));
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

  _convertToFirebaseUser(
      auth.User firebaseUser, String name, String email, String password) {
    return User(
      userId: firebaseUser.uid,
      displayName: name,
      appUserName: name,
      photoUrl: firebaseUser.photoURL ?? "",
      email: email,
      password: password,
      bio: "",
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
    currentUser = null;
  }

  Future<User> getUserById(String userId) async {
    return await dbManager.getUserInfoFromDbById(userId);
  }

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

  Future<void> getCurrentUserById(String userId) async {
    currentUser = await dbManager.getUserInfoFromDbById(userId);
  }
}
