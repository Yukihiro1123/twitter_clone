// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//getLikeResultの返り値にこれを使用
class LikeResult {
  final List<Like> likes;
  final bool isLikeToThisPost;
  LikeResult({required this.likes, required this.isLikeToThisPost});
}

class Like {
  String likeId;
  String postId;
  String likeUserId;
  DateTime likeDateTime;
  Like({
    required this.likeId,
    required this.postId,
    required this.likeUserId,
    required this.likeDateTime,
  });

  Like copyWith({
    String? likeId,
    String? postId,
    String? likeUserId,
    DateTime? likeDateTime,
  }) {
    return Like(
      likeId: likeId ?? this.likeId,
      postId: postId ?? this.postId,
      likeUserId: likeUserId ?? this.likeUserId,
      likeDateTime: likeDateTime ?? this.likeDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'likeId': likeId,
      'postId': postId,
      'likeUserId': likeUserId,
      'likeDateTime': likeDateTime.millisecondsSinceEpoch,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      likeId: map['likeId'] as String,
      postId: map['postId'] as String,
      likeUserId: map['likeUserId'] as String,
      likeDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['likeDateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) =>
      Like.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Like(likeId: $likeId, postId: $postId, likeUserId: $likeUserId, likeDateTime: $likeDateTime)';
  }

  @override
  bool operator ==(covariant Like other) {
    if (identical(this, other)) return true;

    return other.likeId == likeId &&
        other.postId == postId &&
        other.likeUserId == likeUserId &&
        other.likeDateTime == likeDateTime;
  }

  @override
  int get hashCode {
    return likeId.hashCode ^
        postId.hashCode ^
        likeUserId.hashCode ^
        likeDateTime.hashCode;
  }
}
