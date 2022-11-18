import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const Text('登録されているメールアドレスと古いパスワードを入力してください'),
              const Text('現在のメールアドレス'),
              TextField(controller: _emailController),
              const SizedBox(height: 10),
              const Text("古いパスワード"),
              TextField(controller: _passwordController),
              const SizedBox(height: 10),
              const Text("新しいパスワード"),
              TextField(controller: _newPasswordController),
              const SizedBox(height: 10),
              const ElevatedButton(
                onPressed: null,
                child: Text('変更'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
