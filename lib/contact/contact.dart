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
                        title: const CommonText(text:
                          "Kadapa, Andra Pradesh, India, 516227",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: const CommonText(text:"+91 7093 599 788",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: const CommonText(text:"Email: dchandrachaan@gmail.com",
                        ),
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
                          title: const CommonText(text:"Kadapa, Andra Pradesh, India, 516227",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const CommonText(text:"+91 7093 599 788",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const CommonText(text:"Email: dchandrachaan@gmail.com",
                          ),
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
