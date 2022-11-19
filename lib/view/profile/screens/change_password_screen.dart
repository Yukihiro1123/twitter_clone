import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../view_models/profile_view_model.dart';
import '../../common/confirm_dialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text("パスワードの変更"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 100),
              const Text('登録されているメールアドレスを入力してください'),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "現在のメールアドレス *",
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => showConfirmDialog(
                  context: context,
                  title: "パスワードの変更",
                  content: "変更してもいいですか",
                  onConfirmed: (isConfirmed) {
                    if (isConfirmed) {
                      _changePassword(context);
                    }
                  },
                ),
                child: const Text('変更'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _changePassword(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.changePassword(_emailController.text);
  }
}
