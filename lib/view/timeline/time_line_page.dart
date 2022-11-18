import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../view_models/timeline_view_model.dart';
import 'components/timeline_tile.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final timelineViewModel = context.read<TimelineViewModel>();
    Future(() => timelineViewModel.getPosts());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
        ),
        centerTitle: true,
      ),
      body: Consumer<TimelineViewModel>(builder: (context, model, child) {
        if (model.isProcessing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return (model.posts == null)
              ? Container()
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: model.posts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TimelineTile(
                      post: model.posts![index],
                      feedMode: FeedMode.timeline,
                    );
                  },
                );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
