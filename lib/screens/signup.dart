import 'package:musicians/screens/login.dart';
import 'package:musicians/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:io';


bool validateUppercase(String value){ //validator for uppercase character in password
  String  pattern = r'^(?=.*?[A-Z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateLowercase(String value){ //validator for lowercase character in password
  String  pattern = r'^(?=.*?[a-z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateNumber(String value){ //validator for number in password
  String  pattern = r'^(?=.*?[0-9]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool validateSpecialCharacter(String value){ //validator for special character in password
  String  pattern = r'^(?=.*?[!@#\$&*~.]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
bool isEmail(String em) { //validator for email
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}


const List<String> list = <String>['Musician', 'Event Owner', 'Music Enthusiast'];
const List<String> branches= <String>["Acoustic","Blues",'Brass & Marching Band',"Children", "Circus & Funfair",
  "Classical", "Comedy","Country", "Drones","Electronica & Dance","Fanfares",
  "Funk", "Hip Hop", "Jazz", "Latin","Muzak",
  "Pop","Reggae","Rnb & Soul","Rock",
  "Spiritual Music","Traditional Dance","Soul","Folk", "Middle Eastern","Disco",
  "Electronic","Independent"];
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  List tags = [];
  List<String> labels = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final GlobalKey<TagsState> _tagKey = GlobalKey<TagsState>();
  List<String> _selectedGenres = [];
  bool isMember = false;
  bool isMusician = true;
  String _fileText = "";


  @override
  Widget build(BuildContext context) {

    String dropdownValue = list.first;
    String branchValue = branches.first;
    return Scaffold(
        appBar: appBar,
        body: Container(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Container(
                      color: Colors.white54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: DropdownButtonFormField<String>( //account type field
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.assignment_ind_rounded),
                                border: OutlineInputBorder(),
                                labelText: 'Account type',
                              ),
                              value: dropdownValue,
                              onChanged: (String? value) {
                                if (value! == "Musician"){
                                  isMusician = true;
                                  isMember = false;
                                } else if (value! == "Music Enthusiast") {
                                  isMember = true;
                                  isMusician = false;
                                } else {
                                  isMember = false;
                                  isMusician = false;
                                }
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>> ((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          !isMusician ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //name field
                              controller: _name,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: '*Stage Name',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your stage name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          !isMusician ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.assignment_ind_rounded),
                                border: OutlineInputBorder(),
                                labelText: '*Music Genre',
                              ),
                              value: branchValue,
                              onChanged: (String? value) {
                                setState(() {
                                  branchValue = value!;
                                });
                              },
                              items: branches.map<DropdownMenuItem<String>> ((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          !isMember ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: MultiSelectDialogField(
                              buttonText: const Text(
                                "Favorite Genres"
                              ),
                              items: branches.map((e) => MultiSelectItem(e, e.toString())).toList(),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values) {
                                _selectedGenres = values;
                              },
                            ),
                          ),
                          !(!isMusician && !isMember) ?  const SizedBox.shrink() : //if member, do not show
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //body field
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              controller: _address,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter your event\'s address',
                                alignLabelWithHint: true,
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the event address';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //username field
                              controller: _username,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(),
                                labelText: '*Username',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //email field
                              controller: _email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(),
                                labelText: '*Email address',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                } else if (!isEmail(value)){
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField(  //password field
                              controller: _pass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Password',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 8) {
                                  return 'Your password should be longer than 8 characters.';
                                } else if (!validateUppercase(value)) {
                                  return 'Your password should contain at least one upper-case character.';
                                } else if (!validateLowercase(value)) {
                                  return 'Your password should contain at least one lower-case character.';
                                }  else if (!validateNumber(value)) {
                                  return 'Your password should contain at least one number.';
                                }  else if (!validateSpecialCharacter(value)) {
                                  return 'Your password should contain at least one special character.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //confirm password field
                              controller: _confirmPass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: '*Confirm password',
                              ),
                              validator: (value) { //validate
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password.';
                                } else if (value != _pass.text) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: TextFormField( //date of birth field
                              controller: _date,
                              decoration: const InputDecoration (
                                prefixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(),
                                labelText: "*Date of birth",
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1999),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  setState(() {
                                    _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 0.0),
                            child: ElevatedButton(
                              onPressed: () async {
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB( 50.0, 20.0, 10.0, 10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: "By creating an account, you are agreeing to our\n",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
            )
        )
    );
  }

}