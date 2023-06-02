import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/user_info.dart';

class AdminData extends StatefulWidget {
  const AdminData({Key? key}) : super(key: key);

  @override
  State<AdminData> createState() => _AdminDataState();
}

class _AdminDataState extends State<AdminData> {
  List<dynamic> usersData = [];

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  Future<void> callAPI() async {
    usersData.addAll([
      {
        "id": "5",
        "system_name": "MacIntel",
        "browser_name": "Chrome",
        "token_fcm":
            "eBUtJvL8OzdtxWbKsBQz0y:APA91bFuIxxQvIH-n814Q9IHp3nvRkpe8lrRQKECNjFgOOPjesXIik98kF6p3UJ5TuY3F6mz_nOpZu_1FDE3OL3fXtJqEVlUKkA_8v1yaOaPXDmXY_cs7G-ajUL2Byh2fr_2FQMZmC0A",
        "address": "Kadapa, YSR, Andhra Pradesh, 516001, India",
        "battery": "94",
        "wifi": "Connected",
        "sound": "0",
        "dark_theme": "0",
        "color_theme": "ColorSwatch(primary value: Color(0xff2196f3))",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-29 21:15:37"
      },
      {
        "id": "3",
        "system_name": "MacIntel",
        "browser_name": "Chrome",
        "token_fcm": "null",
        "address": "Kadapa, YSR, Andhra Pradesh, 516001, India",
        "battery": "84",
        "wifi": "Connected",
        "sound": "0",
        "dark_theme": "0",
        "color_theme": "ColorSwatch(primary value: Color(0xff2196f3))",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-29 20:56:19"
      },
      {
        "id": "2",
        "system_name": "MacIntel",
        "browser_name": "Chrome",
        "token_fcm": "null",
        "address": "Kadapa, YSR, Andhra Pradesh, 516001, India",
        "battery": "84",
        "wifi": "Connected",
        "sound": "0",
        "dark_theme": "0",
        "color_theme": "ColorSwatch(primary value: Color(0xff2196f3))",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-29 20:56:19"
      },
      {
        "id": "1",
        "system_name": "MacIntel",
        "browser_name": "Chrome",
        "token_fcm":
            "fNrucpJLnXOaFV-2KeiIjq:APA91bHHU-laZjizGWoph3hEGnzL1fu5EFbUCKpHaR4EU1GgveAYPpdW3-ZW_4YgUY8KCFmk929kLxNQH2hzJD7k0ecuH23TfUnpjWy-uwmIFqJlZa51AjX-Z50RiuuTjh7c7-P7SCN4",
        "address": "???, YSR, Andhra Pradesh, 516001, India",
        "battery": "82",
        "wifi": "Connected",
        "sound": "0",
        "dark_theme": "0",
        "color_theme": "ColorSwatch(primary value: Color(0xff2196f3))",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-29 20:53:13"
      }
    ]);
    final response = await http
        .get(Uri.parse('https://chandrachaan.in/randac/item/role_app_users'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      usersData.clear();
      usersData.addAll(jsonData["data"]);

      setState(() {
        // Update your state variables here if needed
      });

      // Do something with the response data
    } else {
      print('status code is:${response.statusCode}');
    }
  }

  void showNotificationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SendNotificationPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: usersData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: usersData.length,
              itemBuilder: (BuildContext context, int index) {
                String themeColor = usersData[index]['darkTheme'] ?? '';
                Color themeCol = getColorFromColorRepresentation(themeColor);
                String formattedDate = formatDate(usersData[index]['date']);

                return UserDataScreen(
                  address: usersData[index]['address'] ?? '',
                  systemName: usersData[index]['system_name'] ?? '',
                  date: formattedDate,
                  browserName: usersData[index]['browser_name'] ?? '',
                  id: usersData[index]['id'] ?? '',
                  tokenFcm: usersData[index]['tokenFcm'] ?? '',
                  battery: usersData[index]['battery'] ?? '',
                  wifi: usersData[index]['wifi'] ?? '',
                  sound: usersData[index]['sound'] ?? '',
                  darkTheme: usersData[index]['darkTheme'] ?? '',
                  colorTheme: themeCol,
                  seenChatScreen: usersData[index]['seenChatScreen'] ?? '',
                  seenFullResume: usersData[index]['seenFullResume'] ?? '',
                  onPre: () {
                    showNotificationPopup(context);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }

  Color getColorFromColorRepresentation(String colorRepresentation) {
    if (colorRepresentation.isEmpty) {
      return Colors.blue;
    } else {
      return Provider.of<UserInfo>(context, listen: false)
          .getColorFromColorRepresentation(colorRepresentation);
    }
  }

  String formatDate(String dateTimeString) {
    if (dateTimeString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('EEEE, MMMM d, y - h:mm a').format(dateTime);
    }
    return '';
  }
}

class UserDataScreen extends StatelessWidget {
  final String id;
  final String systemName;
  final String browserName;
  final String tokenFcm;
  final String address;
  final String battery;
  final String wifi;
  final String sound;
  final String darkTheme;
  final Color colorTheme;
  final String seenChatScreen;
  final String seenFullResume;
  final String date;
  final Function()? onPre;

  const UserDataScreen({
    required this.id,
    required this.systemName,
    required this.browserName,
    required this.tokenFcm,
    required this.address,
    required this.battery,
    required this.wifi,
    required this.sound,
    required this.darkTheme,
    required this.colorTheme,
    required this.seenChatScreen,
    required this.seenFullResume,
    required this.date,
    required this.onPre,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: darkTheme == true ? Colors.black : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip(systemName, Icons.phone_android),
            _buildChip(browserName, Icons.web),
            _buildChip(address, Icons.location_on),
            _buildChip(battery, Icons.battery_full),
            _buildChip('', wifi == 'Connected' ? Icons.wifi : Icons.wifi_off),
            _buildChip('', sound != '0' ? Icons.volume_up : Icons.volume_mute),
            _buildChip('', darkTheme == '0' ? Icons.brightness_2 : Icons.sunny),
            _buildChip(date, Icons.calendar_today),
            if (tokenFcm.isNotEmpty)
              ElevatedButton(
                onPressed: onPre,
                child: const Text('Send Message'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Chip(
      label: Text(label),
      avatar: Icon(
        icon,
        color: colorTheme,
      ),
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(
        color: darkTheme == true ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}

class SendNotificationPopup extends StatelessWidget {
  const SendNotificationPopup();

  @override
  Widget build(BuildContext context) {
    String title = '';
    String message = '';

    return AlertDialog(
      title: const Text('Send Notification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              title = value;
            },
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            onChanged: (value) {
              message = value;
            },
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<UserInfo>(context, listen: false)
                .sendNotification(title: title, dec: message);
          },
          child: const Text('Send'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}


class VisitorScreen extends StatefulWidget {
  @override
  _VisitorScreenState createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  CollectionReference visitorsCollection =
  FirebaseFirestore.instance.collection('visiters');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: visitorsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['age'].toString()),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
