import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/feed/pages/sub/feed_sub_page.dart';
import 'package:insta_clone/view/post/screens/post_upload_screen.dart';
import 'package:insta_clone/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  final FeedMode feedMode;
  const FeedPage({
    super.key,
    required this.feedMode,
  });

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    /*
    Future(
      () => feedViewModel.getPosts(),
    );
    */

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro),
          onPressed: () => _launchCamera(context),
        ),
        title: Text(
          S.of(context).appTitle,
          style: TextStyle(fontFamily: TitleFont),
        ),
      ),
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED,
        index: 0,
      ),
    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(uploadType: UploadType.CAMERA),
      ),
    );
  }
}
