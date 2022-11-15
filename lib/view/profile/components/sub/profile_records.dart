import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/who_cares_me/screens/who_cares_me_screen.dart';
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileRecords extends StatelessWidget {
  const ProfileRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return Row(
      children: <Widget>[
        // 投稿
        FutureBuilder(
          future: profileViewModel.getNumberOfPosts(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: S.of(context).post,
            );
          },
        ),
        // フォロワー
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowers(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
                context: context,
                score: snapshot.hasData ? snapshot.data! : 0,
                title: S.of(context).followers,
                whoCaresMeMode: WhoCaresMeMode.FOLLOWED);
          },
        ),
        // フォロー中
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowing(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
                context: context,
                score: snapshot.hasData ? snapshot.data! : 0,
                title: S.of(context).followings,
                whoCaresMeMode: WhoCaresMeMode.FOLLOWING);
          },
        ),
      ],
    );
  }

  _userRecordWidget({
    required BuildContext context,
    required int score,
    required String title,
    WhoCaresMeMode? whoCaresMeMode,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: whoCaresMeMode == null
            ? null
            : () => _checkFollowUsers(context, whoCaresMeMode),
        child: Column(
          children: <Widget>[
            Text(
              score.toString(),
              style: profileRecordScoreTextStyle,
            ),
            Text(
              title.toString(),
              style: profileRecordTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _checkFollowUsers(BuildContext context, WhoCaresMeMode whoCaresMeMode) {
    final profileViewModel = context.read<ProfileViewModel>();
    final ProfileUser = profileViewModel.profileUser;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WhoCaresMeScreen(
          mode: whoCaresMeMode,
          id: ProfileUser.userId,
        ),
      ),
    );
  }
}
