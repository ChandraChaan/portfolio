import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        "id": "1",
        "system_name": "iphone",
        "browser_name": "chrome",
        "token_fcm": "hhh",
        "address": "pune",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-25 08:45:30"
      },
      {
        "id": "5",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "4",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "6",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "7",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "8",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "9",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "10",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "11",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "0000-00-00 00:00:00"
      },
      {
        "id": "12",
        "system_name": "iphone2",
        "browser_name": "chr2ome",
        "token_fcm": "dgcfvhbhjn",
        "address": "cvhgbj",
        "battery": "60",
        "wifi": "connected",
        "sound": "0",
        "dark_theme": "1",
        "color_theme": "Blue",
        "seen_chat_screen": "0",
        "seen_full_resume": "0",
        "date": "2023-05-26 19:38:07"
      }
    ]);

    final response = await http.get(Uri.parse(
        'https://chandrachaan.in/randac/index.php/item/role_app_users'));

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

  void showNotificationPopup(BuildContext context, String recipientName) {
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
          : ListView.builder(
              itemCount: usersData.length,
              itemBuilder: (BuildContext context, int index) {
                return UserDataScreen(
                  address: usersData[index]['address'] ?? '',
                  systemName: usersData[index]['system_name'] ?? '',
                  date: usersData[index]['date'] ?? '',
                  browserName: usersData[index]['browser_name'] ?? '',
                  id: usersData[index]['id'] ?? '',
                  tokenFcm: usersData[index]['tokenFcm'] ?? '',
                  battery: usersData[index]['battery'] ?? '',
                  wifi: usersData[index]['wifi'] ?? '',
                  sound: usersData[index]['sound'] ?? '',
                  darkTheme: usersData[index]['darkTheme'] ?? '',
                  colorTheme: usersData[index]['colorTheme'] ?? '',
                  seenChatScreen: usersData[index]['seenChatScreen'] ?? '',
                  seenFullResume: usersData[index]['seenFullResume'] ?? '',
                  onPre: () {
                    showNotificationPopup(context, 'John Doe');
                  },
                );
              },
            ),
    );
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
  final String colorTheme;
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('ID', id, Icons.person, Colors.blue),
            _buildInfoRow('System Name', systemName, Icons.phone_android, Colors.orange),
            _buildInfoRow('Browser Name', browserName, Icons.web, Colors.green),
            _buildInfoRow('Token FCM', tokenFcm, Icons.notifications, Colors.red),
            _buildInfoRow('Address', address, Icons.location_on, Colors.purple),
            _buildInfoRow('Battery', battery, Icons.battery_full, Colors.teal),
            _buildInfoRow('Wi-Fi', wifi, Icons.wifi, Colors.amber),
            _buildInfoRow('Sound', sound, Icons.volume_up, Colors.cyan),
            _buildInfoRow('Dark Theme', darkTheme, Icons.brightness_2, Colors.indigo),
            _buildInfoRow('Color Theme', colorTheme, Icons.palette, Colors.pink),
            _buildInfoRow('Seen Chat Screen', seenChatScreen, Icons.visibility, Colors.deepOrange),
            _buildInfoRow('Seen Full Resume', seenFullResume, Icons.visibility_off, Colors.deepPurple),
            _buildInfoRow('Date', date, Icons.calendar_today, Colors.brown),
            const SizedBox(height: 16.0),
            Divider(),
            ElevatedButton(
              onPressed: onPre,
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  value,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class UserDataScreen extends StatelessWidget {
//   final String address;
//   final String systemName;
//   final String date;
//   final String browserName;
//   final Function()? onPre;
//
//   const UserDataScreen({
//     required this.address,
//     required this.systemName,
//     required this.date,
//     required this.browserName,
//     required this.onPre,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               title: Text('Address: $address'),
//               leading: const Icon(Icons.location_on),
//             ),
//             ListTile(
//               title: Text('System Name: $systemName'),
//               leading: const Icon(Icons.computer),
//             ),
//             ListTile(
//               title: Text('Date: $date'),
//               leading: const Icon(Icons.calendar_today),
//             ),
//             ListTile(
//               title: Text('Browser Name: $browserName'),
//               leading: const Icon(Icons.web),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: onPre,
//               child: const Text('Send Message'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
          const Text(
            'System:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Browser:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
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
            Navigator.of(context).pop(); // Close the dialog
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
