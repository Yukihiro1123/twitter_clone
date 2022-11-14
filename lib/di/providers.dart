import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../models/db/database_manager.dart';
import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';
import '../view_models/login_view_model.dart';
import '../view_models/post_view_model.dart';
import '../view_models/profile_view_model.dart';

//...はoperator 配列に変数の要素を挿入
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
];

// If you want to pass variables that can change over time to your object,
// consider using ProxyProvider:
// ProxyProvider is a provider that combines multiple values
// from other providers into a new object and sends the result to Provider.
// That new object will then be updated whenever
// one of the provider we depend on gets updated.
List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, PostRepository>(
    update: (_, dbManager, repo) => PostRepository(dbManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
];
