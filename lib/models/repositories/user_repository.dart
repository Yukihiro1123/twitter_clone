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
}
