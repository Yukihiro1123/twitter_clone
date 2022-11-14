import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_models/profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _signOut(context),
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.signOut();
    context.go('/login');
  }
}
