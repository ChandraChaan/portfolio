import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _subject = '';
  String _confirmPassword = '';

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_userName);
      debugPrint(_subject);
      debugPrint(_confirmPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: (230),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextStyle(
                        "CONTACT US", FontWeight.bold, Colors.black, 40),
                    SizedBox(
                      height: (10),
                    ),
                    SizedBox(
                      width: (180),
                      child: getTextStyle(
                          "It is a long established fact that a reader will  be distracted by the readable content of a  page when looking at its layout.The point of using Lorem Ipsum is that it has a  more- less normal distribution of letters, as opposed to using Content here. ",
                          FontWeight.normal,
                          Colors.black45,
                          20),
                    ),
                    SizedBox(
                      height: (20),
                    ),
                    FittedBox(
                      child: SizedBox(
                        height: (80),
                        width: (180),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Full Name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 4) {
                              return 'Username must be at least 4 characters in length';
                            }
                            return null;
                          },
                          onChanged: (value) => _userName = value,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: SizedBox(
                        height: (80),
                        width: (180),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mail id'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onChanged: (value) => _userEmail = value,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: SizedBox(
                        height: (80),
                        width: (180),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Subject'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }
                            return null;
                          },
                          onChanged: (value) => _subject = value,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: SizedBox(
                        height: (150),
                        width: (180),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'Password must be at least 280 characters in length ';
                            }
                            return null;
                          },
                          onChanged: (value) => _subject = value,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1,
                          ),
                          maxLines: 10,
                          // minLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: (20)),
                    SizedBox(
                      height: (40),
                      width: (20),
                      child: FittedBox(
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.blue)),
                            child: getTextStyle("SEND", FontWeight.bold,
                                Colors.white, 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Colors.blueAccent,
                      size: 60.0,
                    ),
                    getTextStyle(
                        "ADDRESS", FontWeight.bold, Colors.black, 30),
                  ],
                ),
                SizedBox(
                    height: (60),
                    width: (150),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: getTextStyle(
                          "25, Dist town Strees Logn Clifornia, Us",
                          FontWeight.normal,
                          Colors.black45,
                          18),
                    )),
                Row(
                  children: [
                    IconButton(
                      iconSize: 45,
                      color: Colors.blue,
                      icon: const FaIcon(FontAwesomeIcons.phone),
                      onPressed: () {},
                    ),
                    getTextStyle(
                        "PHONE", FontWeight.bold, Colors.black, 30),
                  ],
                ),
                SizedBox(
                  height: (60),
                  width: (160),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: getTextStyle(
                      "800 123 3456 \n900 123 3457",
                      FontWeight.normal,
                      Colors.black45,
                      18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.blueAccent,
                      size: 60.0,
                    ),
                    getTextStyle(
                        "EMAIL", FontWeight.bold, Colors.black, 30),
                  ],
                ),
                SizedBox(
                  height: (60),
                  width: (160),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: getTextStyle(
                        "Fax: 800 123 3456 \nEmail: info@themsbit.com",
                        FontWeight.normal,
                        Colors.black45,
                        18),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 40,
                      color: Colors.indigo,
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 40,
                      color: Colors.blue,
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 40,
                      color: Colors.red,
                      icon: const FaIcon(FontAwesomeIcons.googlePlus),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
