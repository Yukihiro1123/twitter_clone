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
  //final String? popProfileUserId;

  const ProfilePage({
    super.key,
    required this.isOpenFromProfileScreen,
    this.selectedUser,
    //this.popProfileUserId,
  });

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final currentUser = profileViewModel.currentUser;
    profileViewModel.setProfileUser(
      selectedUser,
      //popProfileUserId,
    );
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
                  //profileViewModel.popProfileUser();
                  //_popWithRebuildFollowSdcreen(context, model.popProfileUserId);
                  context.pop();
                },
              ),
        actions: <Widget>[
          (selectedUser != null && selectedUser!.userId == currentUser.userId ||
                  !isOpenFromProfileScreen)
              ? IconButton(
                  onPressed: () => context.push("/settings"),
                  icon: const FaIcon(FontAwesomeIcons.gear),
                )
              : Container(),
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
                          child: ProfileDetailPart(selectedUser: profileUser),
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
              //ツイート
              body: TabBarView(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                      mainAxisSize: MainAxisSize.min,
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

  // void _popWithRebuildFollowSdcreen(BuildContext context, popProfileUserId) {
  //      BuildContext context, String popProfileUserId) {
  //   final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();
  //   whoCaresMeViewModel.rebuildAfterPop(popProfileUserId);
  //   Navigator.pop(context);
  // }
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
