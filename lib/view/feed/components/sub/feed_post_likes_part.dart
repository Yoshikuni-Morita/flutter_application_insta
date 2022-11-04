import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';

class FeedPostLikesPart extends StatelessWidget {
  const FeedPostLikesPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                // TODO
                onPressed: null,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.comment),
                // TODO
                onPressed: null,
              ),
            ],
          ),
          Text("0 ${S.of(context).likes}")
        ],
      ),
    );
  }
}
