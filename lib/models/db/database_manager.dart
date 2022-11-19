import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> unLikeIt(Post post, User currentUser) async {
    final likeRef = await _db
        .collection("likes")
        .where("postId", isEqualTo: post.postId)
        .where("likeUserId", isEqualTo: currentUser.userId)
        .get();
    likeRef.docs.forEach((element) async {
      final ref = _db.collection("likes").doc(element.id);
      await ref.delete();
    });
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

  uploadImageToStorage(File imageFile, String storageId) async {
    //ストレージ上でファイル保存場所のリファレンスを取得
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    //上記のパスにファイルをアップロード
    final uploadTask = storageRef.putFile(imageFile);
    //アップロード処理が完了したらファイルのダウンロードURLを取得
    return uploadTask
        .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<void> updateProfile(User updateUser) async {
    final reference = _db.collection("users").doc(updateUser.userId);
    await reference.update(updateUser.toMap());
  }

  //プロフィール画面
  Future<List<Post>> getPostsByUser(String userId) async {
    final query = await _db.collection('posts').get();
    if (query.docs.isEmpty) return [];
    var results = <Post>[];
    await _db
        .collection("posts")
        .where("userId", isEqualTo: userId)
        .orderBy("postDateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Post.fromMap(element.data()));
      });
    });
    return results;
  }

  //いいねした投稿を取得
  Future<List<Post>> getLikePosts(String userId) async {
    var results = <Post>[];
    //まずはlikesからユーザーがいいねした投稿を持ってくる
    final query = await _db
        .collection("likes")
        .where("likeUserId", isEqualTo: userId)
        .get();
    var likeIds = <String>[];
    query.docs.forEach((id) {
      likeIds.add(id.data()['postId']);
    });
    await _db
        .collection("posts")
        .where("postId", whereIn: likeIds) //TODO 10件しか取ってこれない
        .orderBy("postDateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Post.fromMap(element.data()));
      });
    });
    return results;
  }

  Future<void> deletePost(String postId) async {
    //Post
    final postRef = _db.collection("posts").doc(postId);
    await postRef.delete();
    //Like
    final likeRef =
        await _db.collection("likes").where("postId", isEqualTo: postId).get();
    likeRef.docs.forEach((element) async {
      final ref = _db.collection("likes").doc(element.id);
      await ref.delete();
    });
  }

  Future<void> follow(User profileUser, User currentUser) async {
    //フォローする側(currentUser)のfollowingにprofileUserのuserIdを追加
    await _db
        .collection("users")
        .doc(currentUser.userId)
        .collection("followings")
        .doc(profileUser.userId)
        .set({"userId": profileUser.userId});
    //フォローされる側のfollowersにcurrentUserのuserIdを追加
    await _db
        .collection("users")
        .doc(profileUser.userId)
        .collection("followers")
        .doc(currentUser.userId)
        .set({"userId": profileUser.userId});
  }

  Future<void> unfollow(User profileUser, User currentUser) async {
    //CurrentUserのfollowingsからpostUserIdを削除する
    await _db
        .collection("users")
        .doc(currentUser.userId)
        .collection("followings")
        .doc(profileUser.userId)
        .delete();
    //ProfileUserのfollowerからcurrentUserIdを削除
    await _db
        .collection("users")
        .doc(profileUser.userId)
        .collection("followers")
        .doc(currentUser.userId)
        .delete();
  }

  Future<List<String>> getFollowerUserIds(String userId) async {
    final query =
        await _db.collection("users").doc(userId).collection("followers").get();
    if (query.docs.isEmpty) return [];
    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;
  }

  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _db
        .collection("users")
        .doc(userId)
        .collection("followings")
        .get();
    if (query.docs.isEmpty) return [];
    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()['userId']);
    });
    return userIds;
  }
}
