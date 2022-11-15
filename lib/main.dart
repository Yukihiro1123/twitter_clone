import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/di/providers.dart';
import 'package:twitter_clone/firebase_options.dart';
import 'package:twitter_clone/view/post/tweet_form_screen.dart';
import 'package:twitter_clone/view_models/login_view_model.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'view/likes/likes_page.dart';
import 'view/profile/profile_page.dart';

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
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/new',
        builder: (BuildContext context, GoRouterState state) {
          return const TweetFormScreen();
        },
      ),
      GoRoute(
        path: '/likes',
        builder: (BuildContext context, GoRouterState state) {
          return const LikesPage();
        },
      ),
    ],
  );
}
