/*
This code is adapted from the following website:
https://blog.logrocket.com/implement-infinite-scroll-pagination-flutter/
 */

import 'package:flutter/material.dart';

import 'package:musicians/models/event.dart';
import 'package:musicians/widgets/EventItem.dart';
import 'package:musicians/models/user.dart';

class EventsOverviewScreen extends StatefulWidget {
  EventsOverviewScreen({required this.activeUser});
  final User activeUser;

  @override
  _EventsOverviewScreenState createState() => _EventsOverviewScreenState();
}
class _EventsOverviewScreenState extends State<EventsOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfArticlesPerRequest = 7;
  late List<Event> _events;
  final int _nextPageTrigger = 2;


  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _events = [];
    _isLastPage = false;
    _loading = false;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try{
      List<Event> events = [
      Event(
            1,
            DateTime.utc(2023, 07, 7),
            'Birthday Party in Bebek',
            "ali_yildirim",
            'I am looking for a ',
          "lib/assets/icon/logo.png"),
        Event(
            1,
            DateTime.utc(2023, 05, 16),
            'Pianist for a Wedding in Sarıyer',
            "hulya.akkus",
            'I am looking for a pianist for my sister\'s wedding. We want the pianist to play 3 songs.',
            "lib/assets/icon/logo.png"),
        Event(
            1,
            DateTime.utc(2023, 06, 8),
            'Rock Band Needed for my Pub in Beşiktaş',
            "kardelen.demiral",
            'I need a rock band to play in my pub in Beşiktaş. My pub is called Edinburgh. The band hired should play 80\'s-90\'s popular rock songs. I am considering to give 1000-1500 TL\'s per person for a night.',
            "lib/assets/icon/bar2.jpeg"),
        Event(
            1,
            DateTime.utc(2023, 04, 29),
            'Acoustic Guitar Player Needed',
            "berfinsimsek",
            'address',
            "lib/assets/icon/logo.png"),
        Event(
            1,
            DateTime.utc(2022, 03, 7),
            'Event 1',
            "username",
            'address',
            "lib/assets/icon/logo.png"),
        Event(
            1,
            DateTime.utc(2022, 03, 7),
            'Event 1',
            "username",
            'address',
            "lib/assets/icon/logo.png"),

  ];
      setState(() {
        _loading = false;
        _events.addAll(events);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}){
    return SizedBox(
      height: 180,
      width: 200,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An error occurred when fetching the articles.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
              onPressed:  ()  {
                setState(() {
                  _loading = false;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildArticlesView(),
    );
  }

  Widget buildArticlesView() {
    if (_events.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: errorDialog(size: 20)
        );
      }
    }
    return ListView.builder(
        itemCount: _events.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {

          if (index == _events.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == _events.length) {
            if (_error) {
              return Center(
                  child: errorDialog(size: 15)
              );
            } else {
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
            }
          }
          final Event event = _events[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventItem(activeUser: widget.activeUser,event: event,)
          );
        });
  }

}