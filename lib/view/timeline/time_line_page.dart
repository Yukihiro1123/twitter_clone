import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeLine'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
