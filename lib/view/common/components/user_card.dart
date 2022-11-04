import 'package:flutter/material.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/common/components/circle_photo.dart';

class UserCard extends StatelessWidget {
  final String photoUrl;
  final String title;
  final String subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.photoUrl,
    required this.title,
    required this.subTitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: onTap,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl: photoUrl,
          isImageFromFile: false,
        ),
        title: Text(
          title,
          style: userCardTitleStyle,
        ),
        subtitle: Text(
          subTitle,
          style: userCartSubTitleStyle,
        ),
        trailing: trailing,
      ),
    );
  }
}