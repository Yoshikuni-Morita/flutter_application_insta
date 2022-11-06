import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/feed/components/sub/image_from_url.dart';
import 'package:insta_clone/view/post/components/post_caption_input_text_field.dart';
import 'package:insta_clone/view/post/screens/enlarge_image_screen.dart';
import 'package:insta_clone/view_models/post_view_model.dart';
import 'package:provider/provider.dart';

import 'hero_image.dart';

class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode from;
  final Post? post;
  const PostCaptionPart({super.key, required this.from, this.post});

  @override
  Widget build(BuildContext context) {
    if (from == PostCaptionOpenMode.FROM_POST) {
      final postViewModel = Provider.of<PostViewModel>(context);
      final image = (postViewModel.imageFile != null)
          ? Image.file(postViewModel.imageFile!)
          : Image.asset("assets/images/no_image.png");
      return ListTile(
        leading: HeroImage(
          image: image,
          // TODO
          onTap: () => _displayLargeImage(context, image),
        ),
        title: PostCaptionInputTextField(),
      );
    } else {
      // TODO
      return Column(
        children: <Widget>[
          ImageFromUrl(
            imageUrl: post?.imageUrl,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PostCaptionInputTextField(
              captionBeforeUpdated: post?.caption,
              from: from,
            ),
          ),
        ],
      );
    }
  }

  _displayLargeImage(BuildContext context, Image image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EnlargeImageScreen(image: image),
      ),
    );
  }
}
