import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/feed/components/sub/feed_post_comments_part.dart';
import 'package:insta_clone/view/feed/components/sub/feed_post_header_part.dart';
import 'package:insta_clone/view/feed/components/sub/feed_post_likes_part.dart';
import 'package:insta_clone/view/feed/components/sub/image_from_url.dart';
import 'package:insta_clone/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;

  const FeedPostTile({super.key, required this.feedMode, required this.post});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder(
        future: feedViewModel.getPostUserInfo(post.userId),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final postUser = snapshot.data!;
            final currentUser = feedViewModel.currentUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FeedPostHeaderPart(
                  currentUser: currentUser,
                  post: post,
                  postUser: postUser,
                  feedMode: feedMode,
                ),
                ImageFromUrl(
                  imageUrl: post.imageUrl,
                ),
                FeedPostLikesPart(
                  post: post,
                  postUser: currentUser,
                ),
                FeedPostCommentsPart(
                  postUser: postUser,
                  post: post,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
