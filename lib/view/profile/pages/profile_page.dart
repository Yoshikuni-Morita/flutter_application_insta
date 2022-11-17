import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/profile/components/profile_detail_part.dart';
import 'package:insta_clone/view/profile/components/profile_posts_grid_part.dart';
import 'package:insta_clone/view/profile/components/profile_setting_part.dart';
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:insta_clone/view_models/who_cares_me_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final ProfileMode profileMode;
  final User? selectedUser;
  final bool isOpenFromProfileScreen;
  final String? popProfileUserId;

  const ProfilePage({
    super.key,
    required this.profileMode,
    this.selectedUser,
    required this.isOpenFromProfileScreen,
    this.popProfileUserId,
  });

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.setProfileUser(
        profileMode, selectedUser, popProfileUserId);

    Future(() => profileViewModel.getPost());

    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          final profileUser = model.profileUser;
          print(model.posts);
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leadingWidth: (!isOpenFromProfileScreen) ? 0.0 : 56.0,
                leading: (!isOpenFromProfileScreen)
                    ? Container()
                    : IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          model.popProfileUser();
                          _popWithRebuildWhoCaredMeScreen(
                            context,
                            model.popProfileUserId,
                          );
                        },
                      ),
                title: Text(profileUser.inAppUserName),
                pinned: true,
                floating: true,
                actions: <Widget>[
                  // TODO
                  ProfileSettingPart(
                    mode: profileMode,
                  ),
                ],
                expandedHeight: 280.0,
                flexibleSpace: FlexibleSpaceBar(
                  // TODO
                  background: ProfileDetailPart(
                    mode: profileMode,
                  ),
                ),
              ),
              ProfilePostsGridPart(
                posts: model.posts,
              ),
            ],
          );
        },
      ),
    );
  }

  void _popWithRebuildWhoCaredMeScreen(
      BuildContext context, String popProfileUserId) {
    final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();
    whoCaresMeViewModel.rebuildAfterPop(popProfileUserId);
    Navigator.pop(context);
  }
}
