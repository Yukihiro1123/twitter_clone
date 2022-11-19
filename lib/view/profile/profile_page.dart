import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/constants.dart';

import '../../data_models/user.dart';
import '../../view_models/profile_view_model.dart';
import 'components/profile_detail_part.dart';
import 'components/profile_posts_part.dart';

class ProfilePage extends StatelessWidget {
  final bool isOpenFromProfileScreen;
  final User? selectedUser;

  const ProfilePage({
    super.key,
    required this.isOpenFromProfileScreen,
    this.selectedUser,
  });

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final currentUser = profileViewModel.currentUser;
    profileViewModel.setProfileUser(selectedUser);
    Future(() => profileViewModel.getPosts());
    Future(() => profileViewModel.getLikePosts());

    return Scaffold(
      appBar: AppBar(
        leadingWidth: (!isOpenFromProfileScreen) ? 0.0 : 56.0,
        leading: (!isOpenFromProfileScreen)
            ? Container()
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
        actions: <Widget>[
          //TODO
          (selectedUser != null && selectedUser!.userId == currentUser.userId ||
                  !isOpenFromProfileScreen)
              ? IconButton(
                  onPressed: () => context.go("/settings"),
                  icon: const FaIcon(FontAwesomeIcons.gear),
                )
              : Container(),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
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
                          child: ProfileDetailPart(selectedUser: selectedUser),
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
                      children: <Widget>[
                        (model.posts == null || model.posts!.isEmpty)
                            ? const Center(child: Text('No Tweets yet.'))
                            : Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.posts!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProfilePostsPart(
                                      post: model.posts![index],
                                      feedMode: FeedMode.profile,
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  //いいね
                  Center(
                    child: Column(
                      children: <Widget>[
                        (model.likePosts == null || model.likePosts!.isEmpty)
                            ? const Center(child: Text('No Likes yet.'))
                            : Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.likePosts!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProfilePostsPart(
                                      post: model.likePosts![index],
                                      feedMode: FeedMode.likes,
                                    );
                                  },
                                ),
                              ),
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
