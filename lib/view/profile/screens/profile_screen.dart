import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/profile/pages/profile_page.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  final String popProfileUserId;

  const ProfileScreen({
    super.key,
    required this.popProfileUserId,
    required this.profileMode,
    required this.selectedUser,
  });

  @override
  Widget build(BuildContext context) {
    return ProfilePage(
      profileMode: profileMode,
      selectedUser: selectedUser,
      isOpenFromProfileScreen: true,
      popProfileUserId: popProfileUserId,
    );
  }
}
