import 'package:flutter/material.dart';
import 'package:musicians/models/user.dart';
import 'package:musicians/screens/login.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This is the drawer used in the home page. Using this drawer,
/// a registered user can reach his/her user page, notification center, or settings.
/// A nonregistered user can log in or reach generic settings.
class MyDrawer extends StatelessWidget {
  MyDrawer({this.activeUser});
  final User? activeUser;


  @override
  Widget build(BuildContext context) {
    bool isSessionActive = activeUser!.token != '-1';

    int usertype = activeUser!.usertype; // -1 if session is not active

    String displayName;

    String tempImagePath = 'lib/assets/images/generic_user.jpg';
    Widget pp;
    if (isSessionActive) {
      if (activeUser!.profileImageUrl == null) {
        pp = Image.asset(tempImagePath);
      } else if (activeUser!.usertype == 1) {
        pp = Image.network(activeUser!.profileImageUrl!);
      } else {
        pp = SvgPicture.network(activeUser!.profileImageUrl!);
      }
    } else {
      pp = Image.asset(tempImagePath);
    }

    // While session is active, username or name will be displayed.
    // If not, a "sign in" text is showed.
    if (isSessionActive) {
      displayName = activeUser!.username;
    } else {
      displayName = "Please sign in";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 240,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: const [
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),

          /*
          // If session is active, notifications section is shown.
          isSessionActive ?
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Later, he/she will be directed to the notifications page.
              Navigator.pop(context);
            },
          ): SizedBox.shrink(),
          // Settings section:
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          */

          // If session is active, categories button will show.

          // If session is active, a log out button is shown.
        ],
      ),
    );
  }
}