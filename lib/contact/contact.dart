import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
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
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Provider.of<UserInfo>(context).themeColor,
            width: 50,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: (6),
            width: (120),
            color: Provider.of<UserInfo>(context).themeColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isWeb == false
                ? Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.location_pin,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          "Kadapa, Andra Pradesh, India, 516227",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text("+91 70 93 599 788",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text("Email: dchandrachaan@gmail.com",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.location_pin,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text("Kadapa, Andra Pradesh, India, 516227",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text("+91 70 93 599 788",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text("Email: dchandrachaan@gmail.com",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
