import 'package:flutter/material.dart';
import 'package:musicians/models/user.dart';
import 'package:musicians/widgets/MyDrawer.dart';
import 'package:musicians/widgets/EventsList.dart';
import 'package:musicians/mockData.dart';
import 'package:musicians/screens/eventOverviewScreen.dart';
import 'package:musicians/screens/login.dart';
import 'package:musicians/models/event.dart';

/// This is the implementation of the home page.
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.token, required this.index}) : super(key: key);
  final String token;
  var index;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// currentIndex is for keeping home page status.
  /// 0 for forum, 1 for articles, 2 for chatbot (not implemented yet.)
  @override
  Widget build(BuildContext context) {
    //int currentIndex = widget.index;


    return FutureBuilder<User?>(
      builder: (context,snapshot){

        // If widget token is -1, that means a non registered user
        // entered the home page. If snapshot has data, that means
        // a registered user entered the home page. In both cases
        // we should show the home page. Until that time, a loading
        // icon is shown.

          dynamic result = snapshot.data;

          User activeUser = result ?? User(-1, '-1', '-1', -1);

          List<Widget> bodies = [
            EventsOverviewScreen(activeUser: activeUser,)
          ];

          bool isSessionActive = widget.token != '-1';

          // Floating button that will be used to create posts/articles:
          Widget floatingButton = SizedBox.shrink();
          if (isSessionActive) {
            if (widget.index == 0) {
              floatingButton = FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(builder: (context) =>
                         LoginPage()));
                    print("User create post");
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.create,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ));
            }
          } else {
            floatingButton = const SizedBox.shrink();
          }

          return Scaffold(
            // App bar is the top bar shown in the screen.
            appBar: AppBar(
              title: Image.asset(
                "lib/assets/icon/logo.png",
                fit: BoxFit.contain,
                width: 250,

              ),
              elevation: 0.0,
              actions: <Widget>[
                // This will implement search functionality later:
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30.0,
                )
              ],
            ),

            // Side bar
            drawer: MyDrawer(activeUser: activeUser,),

            // Bottom navigation bar is used for switching between forum, articles and
            // chatbot.
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: widget.index,
              onTap: (index) => setState(() => widget.index = index),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.bubble_chart),
                  label: 'Events',
                ),
                // For now, no chatbot implementation is available.
                BottomNavigationBarItem(
                    icon: Icon(Icons.music_note), label: 'Artists'),
              ],
            ),

            // floating action button will be used for creating a new post or article later.
            floatingActionButton:
            floatingButton, // If user not signed in, do not show create post button in the forum

            body: bodies[widget.index],
          );
      },
    );
  }
}


/*
class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ApiService apiServer = ApiService();
    return FutureBuilder<dynamic>(
      future: apiServer.getSingleArticle(widget.token, 17),
      builder: (context,snapshot){
        return Container();
      },
    );
  }
}
*/