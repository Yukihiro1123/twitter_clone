import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool newUser = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
        centerTitle: true,
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, model, child) {
          return model.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          Text(!newUser ? 'ログイン' : "アカウントの作成"),
                          const SizedBox(height: 20.0),
                          newUser
                              ? TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: "名前 *"),
                                  onChanged: (String value) {
                                    setState(
                                      () => {
                                        name = value,
                                      },
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "名前を入力してください";
                                    }
                                    return null;
                                  })
                              : Container(),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'メールアドレス *'),
                            onChanged: (String value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "メールアドレスを入力してください";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'パスワード *',
                              suffixIcon: IconButton(
                                  icon: Icon(!hidePassword
                                      ? FontAwesomeIcons.solidEye
                                      : FontAwesomeIcons.solidEyeSlash),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  }),
                            ),
                            obscureText: hidePassword,
                            onChanged: (String value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "パスワードを入力してください";
                              } else if (value.length < 6) {
                                return "パスワードが短すぎます";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          newUser
                              ? TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'パスワード（確認）',
                                    suffixIcon: IconButton(
                                        icon: Icon(!hideConfirmPassword
                                            ? FontAwesomeIcons.solidEye
                                            : FontAwesomeIcons.solidEyeSlash),
                                        onPressed: () {
                                          setState(() {
                                            hideConfirmPassword =
                                                !hideConfirmPassword;
                                          });
                                        }),
                                  ),
                                  obscureText: hideConfirmPassword,
                                  onChanged: (String value) {
                                    setState(() {
                                      confirmPassword = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "パスワードを入力してください";
                                    } else if (value.length < 6) {
                                      return "パスワードが短すぎます";
                                    }
                                    return null;
                                  },
                                )
                              : Container(),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  !newUser ? signIn(context) : signUp(context);
                                }
                              },
                              child: Text(!newUser ? "ログイン" : "新規登録"),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => _switchAuth(),
                              child:
                                  Text(!newUser ? "新規登録" : 'アカウントをお持ちの方はこちら'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  _switchAuth() {
    setState(() {
      newUser = !newUser;
    });
  }

  signIn(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    await loginViewModel.signIn(email, password);
    if (!mounted) return;
    context.go('/');
  }

  signUp(BuildContext context) async {
    if (password == confirmPassword) {
      final loginViewModel = context.read<LoginViewModel>();
      await loginViewModel.signUp(name, email, password);
      if (!loginViewModel.isSuccessful) {
        return;
      }
      if (!mounted) return;
      context.go('/register_done');
    } else {
      Fluttertoast.showToast(msg: "パスワードが一致しません");
      return;
    }
  }
}
