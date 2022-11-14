import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

//Flutter でダイアログを表示するにはshowDialog メソッドを使う
//package:flutter/material.dartをインポートすることで使用可能
showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required ValueChanged onConfirmed,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ConfirmDialog(
            title: title,
            content: content,
            onConfirmed: onConfirmed,
          ));
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;
  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
              child: const Text('はい'),
              onPressed: () {
                context.pop();
                onConfirmed(true);
              }),
          TextButton(
              child: const Text('いいえ'),
              onPressed: () {
                context.pop();
                onConfirmed(false);
              }),
        ]);
  }
}
