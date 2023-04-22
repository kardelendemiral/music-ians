import 'package:flutter/material.dart';
import 'package:musicians/models/event.dart';
import 'package:intl/intl.dart';
import 'package:musicians/screens/viewEvent.dart';
import 'package:musicians/models/user.dart';

class EventItem extends StatelessWidget{
  EventItem({required this.activeUser, required this.event,});
  final User activeUser;
  final Event event;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewEventPage(
                event: event,
                activeUser: activeUser,
              )
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          height: 155,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(event.header.toUpperCase(),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        event.userame,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            formatter.format(event.time),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
