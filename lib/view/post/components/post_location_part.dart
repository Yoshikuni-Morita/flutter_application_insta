import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/data_models/location.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/post/screens/map_screen.dart';
import 'package:insta_clone/view_models/post_view_model.dart';
import 'package:provider/provider.dart';

class PostLocationPart extends StatelessWidget {
  const PostLocationPart({super.key});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return ListTile(
      title: Text(
        postViewModel.locationString,
        style: postLocationTextStyle,
      ),
      subtitle: _latLngPart(postViewModel.location, context),
      trailing: IconButton(
        icon: FaIcon(FontAwesomeIcons.locationDot),
        // TODO
        onPressed: () => _openMapScreen(context, postViewModel.location),
      ),
    );
  }

  // TODO
  _latLngPart(Location? location, BuildContext context) {
    const spaceWidth = 8.0;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Chip(
          label: Text(S.of(context).latitude),
        ),
        SizedBox(
          width: spaceWidth,
        ),
        Text(
            (location != null) ? location.latitude.toStringAsFixed(2) : "0.00"),
        SizedBox(
          width: spaceWidth,
        ),
        Chip(
          label: Text(S.of(context).longitude),
        ),
        SizedBox(
          width: spaceWidth,
        ),
        Text(
            (location != null) ? location.longitude.toStringAsFixed(2) : "0.00")
      ],
    );
  }

  _openMapScreen(BuildContext context, Location? location) {
    if (location == null) return;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MapScreen(location: location),
        ));
  }
}
