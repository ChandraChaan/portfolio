import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Contact extends StatelessWidget {
final bool isWeb;

  const Contact({super.key, this.isWeb = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
        border: const Border(
          bottom: BorderSide(
            color: Colors.blueAccent,
            width: 50,
          ),
        ),
      ),
      child: Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isWeb == false ?
            Column(
              children: const [
                ListTile(
                  leading: Icon(
                    Icons.location_pin,
                    color: Colors.blueAccent,
                  ),
                  title: Text("Kadapa, Andra Pradesh, India, 516227"),
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.blueAccent,
                  ),
                  title: Text("+91 70 93 599 788"),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Colors.blueAccent,
                  ),
                  title: Text("Email: dchandrachaan@gmail.com"),
                ),
              ],
            ) :
            Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Icon(
                      Icons.location_pin,
                      color: Colors.blueAccent,
                    ),
                    title: Text("Kadapa, Andra Pradesh, India, 516227"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.blueAccent,
                    ),
                    title: Text("+91 70 93 599 788"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: Colors.blueAccent,
                    ),
                    title: Text("Email: dchandrachaan@gmail.com"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80,)
        ],
      ),
    );
  }
}
