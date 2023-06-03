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

  // @override
  // void initState() {
  //   super.initState();
  //   callAPI();
  // }
  //
  // Future<void> callAPI() async {
  //   final response = await http
  //       .get(Uri.parse('https://chandrachaan.in/randac/item/role_app_users'));
  //
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonData = json.decode(response.body);
  //     usersData.clear();
  //     usersData.addAll(jsonData["data"]);
  //
  //     setState(() {
  //       // Update your state variables here if needed
  //     });
  //
  //     // Do something with the response data
  //   } else {
  //     print('status code is:${response.statusCode}');
  //   }
  // }

  void showNotificationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SendNotificationPopup();
      },
    );
  }

  CollectionReference visitorsCollection =
      FirebaseFirestore.instance.collection('visiters');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
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
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String formattedDate =
                  formatDate(data['date'] ?? DateTime.now().toString());
              return UserDataScreen(
                address: data['address'] ?? '',
                systemName: data['system_name'] ?? '',
                date: formattedDate,
                browserName: data['browser_name'] ?? '',
                tokenFcm: data['tokenFcm'] ?? '',
                battery: data['battery'] ?? '',
                wifi: data['wifi'] ?? '',
                sound: data['sound'].toString(),
                darkTheme: data['dark_theme'].toString(),
                colorTheme: data['color_theme'] ?? '',
                seenChatScreen: data['seenChatScreen'] ?? '',
                seenFullResume: data['seenFullResume'] ?? '',
                onPre: () {
                  showNotificationPopup(context);
                },
              );
            }).toList(),
          );
        },
      ),
      // body: usersData.isEmpty
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         itemCount: usersData.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           String themeColor = usersData[index]['darkTheme'] ?? '';
      //           Color themeCol = getColorFromColorRepresentation(themeColor);
      //           String formattedDate = formatDate(usersData[index]['date']);
      //
      //           return UserDataScreen(
      //             address: usersData[index]['address'] ?? '',
      //             systemName: usersData[index]['system_name'] ?? '',
      //             date: formattedDate,
      //             browserName: usersData[index]['browser_name'] ?? '',
      //             id: usersData[index]['id'] ?? '',
      //             tokenFcm: usersData[index]['tokenFcm'] ?? '',
      //             battery: usersData[index]['battery'] ?? '',
      //             wifi: usersData[index]['wifi'] ?? '',
      //             sound: usersData[index]['sound'] ?? '',
      //             darkTheme: usersData[index]['darkTheme'] ?? '',
      //             colorTheme: themeCol,
      //             seenChatScreen: usersData[index]['seenChatScreen'] ?? '',
      //             seenFullResume: usersData[index]['seenFullResume'] ?? '',
      //             onPre: () {
      //               showNotificationPopup(context);
      //             },
      //           );
      //         },
      //         separatorBuilder: (BuildContext context, int index) {
      //           return const Divider();
      //         },
      //       ),
    );
  }

  Color getColorFromColorRepresentation(String colorRepresentation) {
    if (colorRepresentation.isEmpty) {
      return Colors.blue;
    } else {
      return Colors
          .blue; /*Provider.of<UserInfo>(context, listen: false)
          .getColorFromColorRepresentation(colorRepresentation);*/
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
  final String systemName;
  final String browserName;
  final String tokenFcm;
  final String address;
  final String battery;
  final String wifi;
  final String sound;
  final String darkTheme;
  final String colorTheme;
  final String seenChatScreen;
  final String seenFullResume;
  final String date;
  final Function()? onPre;

  const UserDataScreen({
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
      color: darkTheme.toString() == 'true' ? Colors.black : Colors.white,
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
            _buildChip('', sound.toString() != 'false' ? Icons.volume_up : Icons.volume_off),
            _buildChip('', darkTheme.toString() == 'true' ? Icons.brightness_2 : Icons.sunny),
            _buildChip(date, Icons.calendar_today),
            if (tokenFcm.toString().isNotEmpty && tokenFcm.toString() != 'null')
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
    // int _color =
    return Chip(
      label: Text(label),
      avatar: Icon(
        icon,
        color: (colorTheme.toString() != 'null' && colorTheme.toString().isNotEmpty) ? Color(int.parse(colorTheme)): null,
      ),
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(
        color: darkTheme.toString() == 'true' ? Colors.white : Colors.black,
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
