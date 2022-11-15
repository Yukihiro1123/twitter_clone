import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twitter_clone/data_models/like.dart';
import 'package:twitter_clone/data_models/post.dart';
import "../../data_models/user.dart";

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection('user')
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();
    if (query.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    //collection userのdocument idをuser idにしてuser.dartのデータ型を入れる
    await _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query =
        await _db.collection('users').where("userId", isEqualTo: userId).get();
    return User.fromMap(query.docs[0].data());
  }

  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
  }

  //タイムライン画面
  Future<List<Post>> getPosts() async {
    final query = await _db
        .collection('posts')
        .orderBy("postDateTime", descending: true)
        .get();
    if (query.docs.isEmpty) return [];
    var results = <Post>[];
    query.docs.forEach((element) {
      results.add(Post.fromMap(element.data()));
    });
    return results;
  }

  Future<void> likeIt(Like like) async {
    await _db.collection("likes").doc(like.likeId).set(like.toMap());
  }

  Future<List<Like>> getLikes(String postId) async {
    //データがあるかどうかの判定
    final query = await _db.collection("likes").get();
    if (query.docs.isEmpty) return [];
    var results = <Like>[];
    await _db
        .collection("likes")
        .where("postId", isEqualTo: postId)
        .orderBy("likeDateTime")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Like.fromMap(element.data()));
      });
    });
    return results;
  }

  //プロフィール画面
}
