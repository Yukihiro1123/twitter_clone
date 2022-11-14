// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  String postId;
  String userId;
  DateTime postDateTime;
  String tweetText;
  Post({
    required this.postId,
    required this.userId,
    required this.postDateTime,
    required this.tweetText,
  });

  Post copyWith({
    String? postId,
    String? userId,
    DateTime? postDateTime,
    String? tweetText,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      postDateTime: postDateTime ?? this.postDateTime,
      tweetText: tweetText ?? this.tweetText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'userId': userId,
      'postDateTime': postDateTime.millisecondsSinceEpoch,
      'tweetText': tweetText,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      postDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['postDateTime'] as int),
      tweetText: map['tweetText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(postId: $postId, userId: $userId, postDateTime: $postDateTime, tweetText: $tweetText)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.userId == userId &&
        other.postDateTime == postDateTime &&
        other.tweetText == tweetText;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        userId.hashCode ^
        postDateTime.hashCode ^
        tweetText.hashCode;
  }
}
