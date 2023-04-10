import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
                    width: (190),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: getTextStyle(
                          "Kadapa, Andra Pradesh, India, 516227",
                          FontWeight.normal,
                          Colors.black45,
                          18),
                    )),
              ],
            ),
            Column(
              children: [
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
                      "+91 7093 599 788",
                      FontWeight.normal,
                      Colors.black45,
                      18,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
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
                        "Email: dchandrachaan@gmail.com",
                        FontWeight.normal,
                        Colors.black45,
                        18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
