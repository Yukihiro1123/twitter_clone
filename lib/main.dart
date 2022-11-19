import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/di/providers.dart';
import 'package:twitter_clone/firebase_options.dart';

import 'package:twitter_clone/view/post/tweet_form_screen.dart';
import 'package:twitter_clone/view/profile/screens/edit_profile_screen.dart';
import 'package:twitter_clone/view_models/login_view_model.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

import 'view/profile/screens/change_email_screen.dart';
import 'view/profile/screens/change_password_screen.dart';
import 'view/profile/screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: globalProviders, child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Twitter Clone',
      //homeが指定できない
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        redirect: (context, state) async {
          if (await context.read<LoginViewModel>().isSignIn()) {
            // No redirect is required if the user is already logged in.
            return null;
          }
          return '/login';
        },
      ),
      //ログイン画面
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      //投稿フォーム
      GoRoute(
        path: '/new',
        builder: (BuildContext context, GoRouterState state) {
          return const TweetFormScreen();
        },
      ),
      //プロフィール画面
      GoRoute(
        path: "/profile/:user_id",
        builder: (BuildContext context, GoRouterState state) {
          final String userId = state.params['user_id']!;
          return ProfileScreen(
            userId: userId,
          );
        },
      ),
      //設定
      GoRoute(
        path: "/settings",
        builder: (BuildContext context, GoRouterState state) {
          return const SettingScreen();
        },
      ),
      //プロフィール編集
      GoRoute(
        path: "/edit_profile",
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfileScreen();
        },
      ),
      //メールアドレス変更
      GoRoute(
        path: "/change_email",
        builder: (BuildContext context, GoRouterState state) {
          return const ChangeEmailScreen();
        },
      ),
      //パスワード変更
      GoRoute(
        path: "/change_password",
        builder: (BuildContext context, GoRouterState state) {
          return const ChangePasswordScreen();
        },
      ),
    ],
  );
}
