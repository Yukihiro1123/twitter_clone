import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/style.dart';

import '../../../view_models/profile_view_model.dart';
import '../../common/confirm_dialog.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  TextEditingController _newEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text("メールアドレスの変更"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text('メールアドレスを変更する', style: settingTitleStyle),
              const SizedBox(height: 10),
              const Text('新しいメールアドレスに確認メールを送信します', style: settingcaptionStyle),
              const SizedBox(height: 30),
              const Text('現在のメールアドレス'),
              Text(profileUser.email),
              const SizedBox(height: 20),
              TextField(
                controller: _newEmailController,
                decoration: const InputDecoration(
                  labelText: "新しいメールアドレス",
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => showConfirmDialog(
                  context: context,
                  title: "パスワードの変更",
                  content: "変更してもいいですか",
                  onConfirmed: (isConfirmed) {
                    if (isConfirmed) {
                      _changeEmail(context);
                    }
                  },
                ),
                child: Text('確認メールを送信'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _changeEmail(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.changeEmail(_newEmailController.text);
  }
}
