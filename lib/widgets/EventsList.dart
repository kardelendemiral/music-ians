import 'package:flutter/material.dart';
import 'package:musicians/models/event.dart';
import 'package:musicians/widgets/EventItem.dart';
import 'package:musicians/models/user.dart';


/// This code was used for listing all articles but
/// it is obsolete. Kept for possible later uses.
class EventsList extends StatelessWidget{
  EventsList({required this.activeUser, required this.events});
  final User activeUser;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        final event = events[index];
        return EventItem(activeUser: activeUser, event: event,);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}