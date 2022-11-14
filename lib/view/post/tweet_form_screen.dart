import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/common/confirm_dialog.dart';

import 'package:twitter_clone/view/post/component/post_input_text_field.dart';

import '../../view_models/post_view_model.dart';

class TweetFormScreen extends StatelessWidget {
  const TweetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: model.isProcessing
              ? Container()
              : TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('キャンセル',
                      style: TextStyle(color: Colors.black)),
                ),
          iconTheme: const IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => showConfirmDialog(
                  context: context,
                  title: "投稿",
                  content: "投稿してもいいですか",
                  onConfirmed: (isConfirmed) {
                    if (isConfirmed) {
                      _post(context);
                    }
                  },
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: const Text('ツイートする'),
              ),
            )
          ],
        ),
        body: model.isProcessing
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.white,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      //アイコン
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(FontAwesomeIcons.solidUser),
                        ),
                      ),
                      //
                      Expanded(
                        flex: 4,
                        child: PostInputTextField(),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }

//TODO ツイート投稿処理
  void _post(BuildContext context) async {
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.post();
    context.pop();
  }
}
