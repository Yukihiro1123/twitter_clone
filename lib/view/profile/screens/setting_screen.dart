import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../view_models/profile_view_model.dart';
import '../../common/confirm_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text("設定"),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: TextButton(
            child: const Text('メールアドレスの変更'),
            onPressed: () => context.push('/change_email'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            child: const Text('パスワードの変更'),
            onPressed: () => context.push('/change_password'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            child: const Text('ログアウト'),
            onPressed: () => showConfirmDialog(
              context: context,
              title: "ログアウト",
              content: "ログアウトしてもいいですか",
              onConfirmed: (isConfirmed) {
                if (isConfirmed) {
                  _signOut(context);
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  _signOut(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.signOut();
    context.go('/login');
  }
}
