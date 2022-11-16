import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data_models/user.dart';
import '../../view_models/profile_view_model.dart';
import 'components/profile_detail_part.dart';

class ProfilePage extends StatelessWidget {
  final User? selectedUser;

  const ProfilePage({
    super.key,
    this.selectedUser,
  });

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.setProfileUser(selectedUser);
    Future(() => profileViewModel.getPost());
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => _signOut(context),
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          final profileUser = model.profileUser;
          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          color: Colors.white,
                          child: ProfileDetailPart(),
                        )
                      ],
                    ),
                  ),
                  const SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyTabBarDelegate(
                      tabBar: TabBar(
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'ツイート',
                          ),
                          Tab(
                            text: 'いいね',
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: const <Widget>[
                        Text('Tweet'),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: const <Widget>[
                        Text("Like"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
