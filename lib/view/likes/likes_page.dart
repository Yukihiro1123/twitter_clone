import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LikesPage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
