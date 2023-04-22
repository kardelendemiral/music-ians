// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musicians/mockData.dart';
import 'package:musicians/models/event.dart';
import 'package:intl/intl.dart';
import 'package:musicians/models/user.dart';
import 'package:musicians/screens/home.dart';
import 'package:musicians/widgets/appBar.dart';
import 'package:flutter_html/flutter_html.dart';

enum Menu { itemOne, itemTwo, itemThree }

class ViewEventPage extends StatefulWidget {
  const ViewEventPage(
      {Key? key, required this.activeUser, required this.event,})
      : super(key: key);
  final User activeUser;
  final Event event;

  @override
  State<ViewEventPage> createState() => _ViewEventPageState();
}

class _ViewEventPageState extends State<ViewEventPage> {


  String tempImagePath = 'lib/assets/images/generic_user.jpg';

  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');
  @override
  Widget build(BuildContext context) {
    User activeUser = widget.activeUser;
    Event event = widget.event;
    bool isSessionActive = activeUser.token != '-1';
    String token = activeUser.token;
    int eventid = widget.event.id;
    Widget pp;


    String tempImagePath = 'lib/assets/icon/bar.png';
    pp = Image.asset(tempImagePath);
    return Scaffold(
      appBar: appBar,
      body:


      ListView(children: [

        Container(
          constraints: BoxConstraints(maxHeight: double.infinity),
          color: Theme.of(context).colorScheme.surface,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {

                      },
                      child: CircleAvatar(
                          radius: 20,
                          child: ClipOval(
                            child: pp,
                          )
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () async {
                                },
                                child: Text(
                                  event.userame,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text(
                                "Event Time: " +
                                    formatter.format(event.time),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0),
                    LayoutBuilder(builder: (context, constraints) {
                      return PopupMenuButton<Menu>(
                        onSelected: (Menu item) {
                          setState(() {
                            if(item == Menu.itemOne) {
                              print("Report article");
                            }
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                          const PopupMenuItem<Menu>(
                            value: Menu.itemOne,
                            child: Text('Report'),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  event.header,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(5.0),
                constraints: BoxConstraints(maxHeight: double.infinity),
                width: double.infinity,
                child: Text(
                  event.address,
                  maxLines: 15,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Image(image: AssetImage(event.profileImageUrl!)),
              SizedBox(height: 8),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 250,
            ),
            ElevatedButton(
              onPressed: () async {
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.handshake,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Create Offer',
                  ),
                ],
              ),
            )
          ],
        )

      ]),

    );
  }
}

class CategoryViewer extends StatelessWidget {
  CategoryViewer({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(width: 15.0),
              Icon(
                Icons.category,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(width: 10.0),
              Container(width: 150,
                  child: Text(name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary))),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ],
    );
  }
}

bool containsListTags(String htmlString){
  return htmlString.contains(RegExp(r'</?[uo]l>')) || htmlString.contains(RegExp(r'</?li>'));
}

String removeHtmlTags(String htmlString){
  String cleaned = htmlString.replaceAll(RegExp(r"</p>"), ' ');
  cleaned = cleaned.replaceAll(RegExp(r"\n+"), '\n');
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  return cleaned.replaceAll(exp, '');
}


Color randomColor(){

  List<dynamic> lst = [0xA50D0D, 0X0DA256, 0x1D0DA5, 0xa50d57, 0x7ba50d, 0x1a174d, 0x05695e, 0x311a80, 0x711111, 0x1a1a97, 0x1616c8, 0x000ae6];
  return Color(lst[Random().nextInt(lst.length)].toInt()).withOpacity(1.0);
}