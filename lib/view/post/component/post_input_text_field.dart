import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/post_view_model.dart';

class PostInputTextField extends StatefulWidget {
  const PostInputTextField({super.key});

  @override
  State<PostInputTextField> createState() => _PostInputTextFieldState();
}

class _PostInputTextFieldState extends State<PostInputTextField> {
  final _formKey = GlobalKey<FormState>();
  //String tweetText = "";
  final _tweetTextController = TextEditingController();
  @override
  void initState() {
    _tweetTextController.addListener(_onTweetTextUpdated);
    super.initState();
  }

  @override
  void dispose() {
    _tweetTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        controller: _tweetTextController,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "今どうしてる？",
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'テキストを入力してください';
          }
          return null;
        },
      ),
    );
  }

  _onTweetTextUpdated() {
    final viewModel = context.read<PostViewModel>();
    viewModel.tweetText = _tweetTextController.text;
  }
}
