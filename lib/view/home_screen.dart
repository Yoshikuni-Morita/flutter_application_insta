import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/activities/pages/activities_page.dart';
import 'package:insta_clone/view/feed/pages/feed_page.dart';
import 'package:insta_clone/view/post/pages/post_page.dart';
import 'package:insta_clone/view/profile/pages/profile_page.dart';
import 'package:insta_clone/view/search/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _pages = [
      FeedPage(feedMode: FeedMode.FROM_FEED,),
      SearchPage(),
      PostPage(),
      ActivitiesPage(),
      ProfilePage(profileMode: ProfileMode.MYSELF, isOpenFromProfileScreen: false,),
    ];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: S.of(context).search,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.squarePlus),
              label: S.of(context).add,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart),
              label: S.of(context).activities,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: S.of(context).user,
            ),
          ]),
    );
  }
}
