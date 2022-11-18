enum FirebaseAuthError {
  userNotFound,
  userDisabled,
  requiresRecentLogin,
  emailAlreadyInUse,
  invalidEmail,
  wrongPassword,
  tooManyRequests,
  expiredActionCode,
  unknown,
}

enum FeedMode {
  likes, //いいね
  profile, //プロフィール 特定ユーザーのツイート
  timeline, //タイムライン 全てのツイート？
}
