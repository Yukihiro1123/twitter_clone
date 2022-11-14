import 'package:twitter_clone/data_models/user.dart';
import 'package:uuid/uuid.dart';

import '../../data_models/post.dart';
import '../db/database_manager.dart';

class PostRepository {
  final DatabaseManager dbManager;
  PostRepository({required this.dbManager});

  Future<void> post(User currentUser, String tweetText) async {
    final storageId = const Uuid().v1();
    final post = Post(
      postId: storageId,
      userId: currentUser.userId,
      tweetText: tweetText,
      postDateTime: DateTime.now(),
    );
    await dbManager.insertPost(post);
  }
}
