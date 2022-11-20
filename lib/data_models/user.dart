// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class User {
  final String userId;
  //firebaseに登録したUser情報に紐づいているユーザー名
  final String displayName;
  //Twitterで使われる名前
  final String appUserName;
  //プロフィール画像
  final String photoUrl;
  final String email;
  //自己紹介
  final String bio;
  User({
    required this.userId,
    required this.displayName,
    required this.appUserName,
    required this.photoUrl,
    required this.email,
    required this.bio,
  });

  User copyWith({
    String? userId,
    String? displayName,
    String? appUserName,
    String? photoUrl,
    String? email,
    String? bio,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      appUserName: appUserName ?? this.appUserName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'displayName': displayName,
      'appUserName': appUserName,
      'photoUrl': photoUrl,
      'email': email,
      'bio': bio,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      appUserName: map['appUserName'] as String,
      photoUrl: map['photoUrl'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, displayName: $displayName, appUserName: $appUserName, photoUrl: $photoUrl, email: $email, bio: $bio)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.displayName == displayName &&
        other.appUserName == appUserName &&
        other.photoUrl == photoUrl &&
        other.email == email &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        displayName.hashCode ^
        appUserName.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        bio.hashCode;
  }
}
