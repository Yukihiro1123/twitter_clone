//ユーザー登録時にここに遷移
import "package:flutter/material.dart";

class RegisterDoneScreen extends StatelessWidget {
  const RegisterDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ユーザー登録完了"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: const <Widget>[
              SizedBox(height: 40.0),
              Text('認証メールが送信されました'),
              SizedBox(height: 40.0),
              Text('メール認証を完了し、再度サインインしてください'),
            ],
          ),
        ));
  }
}
