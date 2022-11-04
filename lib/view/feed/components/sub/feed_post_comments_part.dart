import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';

class FeedPostCommentsPart extends StatelessWidget {
const FeedPostCommentsPart({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: null,
            child: Text(
              "0 ${S.of(context).comments}",
              style: numberOfCommentsTextStyle,
            ),
          ),
          Text(
            "0 時間前", style: timeAgoTextStyle,
          ),
        ],
      ),
    );
  }
}