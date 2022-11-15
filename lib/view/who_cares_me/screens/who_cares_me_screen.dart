import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/common/components/user_card.dart';
import 'package:insta_clone/view/profile/screens/profile_screen.dart';
import 'package:insta_clone/view_models/who_cares_me_view_model.dart';
import 'package:provider/provider.dart';

class WhoCaresMeScreen extends StatelessWidget {
  final WhoCaresMeMode mode;
  final String id;

  const WhoCaresMeScreen({
    super.key,
    required this.mode,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();

    Future(() => whoCaresMeViewModel.getCaresMeUsers(id, mode));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleText(context, mode),
        ),
      ),
      body: Consumer<WhoCaresMeViewModel>(builder: (_, model, child) {
        return model.caresMeUsers.isEmpty
            ? Container()
            : ListView.builder(
                itemCount: model.caresMeUsers.length,
                itemBuilder: (_, int index) {
                  final user = model.caresMeUsers[index];
                  return UserCard(
                    photoUrl: user.photoUrl,
                    title: user.inAppUserName,
                    subTitle: user.bio,
                    onTap: () => _openProfileScreen(context, user),
                    trailing: null,
                  );
                },
              );
      }),
    );
  }

  String _titleText(BuildContext context, WhoCaresMeMode mode) {
    var titelText = "";
    switch (mode) {
      case WhoCaresMeMode.LIKE:
        titelText = S.of(context).likes;
        break;
      case WhoCaresMeMode.FOLLOWING:
        titelText = S.of(context).followings;
        break;
      case WhoCaresMeMode.FOLLOWED:
        titelText = S.of(context).followers;
        break;
    }
    return titelText;
  }

  _openProfileScreen(BuildContext context, User user) {
    final whoCaresMeViewModel = context.read<WhoCaresMeViewModel>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          profileMode: user.userId == whoCaresMeViewModel.currentUser.userId
              ? ProfileMode.MYSELF
              : ProfileMode.OTHER,
          selectedUser: user,
        ),
      ),
    );
  }
}
