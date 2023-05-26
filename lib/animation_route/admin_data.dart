import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// class AdminData extends StatefulWidget {
//   const AdminData({Key? key}) : super(key: key);
//
//   @override
//   State<AdminData> createState() => _AdminDataState();
// }
//
// class _AdminDataState extends State<AdminData> {
//   void showNotificationPopup(BuildContext context, String recipientName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const SendNotificationPopup(systemName: 'Mac', browserName: 'Chrome',);
//       },
//     );
//   }
//   @override
//   void initState() {
//     super.initState();
//     callapi();
//     print('Aruna1111');
//
//   }
//
//   List<dynamic> usersData = [];
//
//   Future<void> callAPI() async {
//     final response = await http.get(Uri.parse('https://chandrachaan.in/randac/index.php/item/role_app_users'));
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonData = json.decode(response.body);
//       usersData.addAll(jsonData["data"]);
//
//       setState(() {
//         // Update your state variables here if needed
//       });
//
//       print(usersData.length);
//       print('Aruna');
//
//       // Do something with the response data
//     } else {
//       // Handle error
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Data'),
//       ),
//
//       body:usersData.length==0?Center(child: CircularProgressIndicator()): ListView.builder(
//         itemCount: usersData.length,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           return  UserDataScreen(
//             address: usersData[index]['address'],
//             systemName:  usersData[index]['system_name'],
//             date: usersData[index]['date'],
//             browserName: usersData[index]['browser_name'],
//             onPre: (){
//               showNotificationPopup(context, 'John Doe');
//             },
//
//           );
//         },
//       ),
//     );
//   }
//
//   void callapi() {}
// }
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
    print('Aruna1111');
  }

  Future<void> callAPI() async {
    final response = await http.get(Uri.parse('https://chandrachaan.in/randac/index.php/item/role_app_users'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      usersData.addAll(jsonData["data"]);

      setState(() {
        // Update your state variables here if needed
      });

      print(usersData.length);
      print('Aruna');

      // Do something with the response data
    } else {
      // Handle error
    }
  }

  void showNotificationPopup(BuildContext context, String recipientName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SendNotificationPopup(systemName: 'Mac', browserName: 'Chrome');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: usersData.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: usersData.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return UserDataScreen(
            address: usersData[index]['address'],
            systemName: usersData[index]['system_name'],
            date: usersData[index]['date'],
            browserName: usersData[index]['browser_name'],
            onPre: () {
              showNotificationPopup(context, 'John Doe');
            },
          );
        },
      ),
    );
  }
}

// class UserDataScreen extends StatelessWidget {
//   final String address;
//   final String systemName;
//   final String date;
//   final String browserName;
//   final VoidCallback onPre;
//
//   const UserDataScreen({
//     Key? key,
//     required this.address,
//     required this.systemName,
//     required this.date,
//     required this.browserName,
//     required this.onPre,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(address),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(systemName),
//           Text(date),
//           Text(browserName),
//         ],
//       ),
//       onTap: onPre,
//     );
//   }
// }

// class SendNotificationPopup extends StatelessWidget {
//   final String systemName;
//   final String browserName;
//
//   const SendNotificationPopup({
//     Key? key,
//     required this.systemName,
//     required this.browserName,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Send Notification'),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('System Name: $systemName'),
//           Text('Browser Name: $browserName'),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//       ],
//     );
//   }
// }

class UserDataScreen extends StatelessWidget {
  final String address;
  final String systemName;
  final String date;
  final String browserName;
  final Function()? onPre;

  const UserDataScreen({
    required this.address,
    required this.systemName,
    required this.date,
    required this.browserName,
    required this.onPre,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Address'),
              subtitle: Text(address),
              leading: const Icon(Icons.location_on),
            ),
            ListTile(
              title: const Text('System Name'),
              subtitle: Text(systemName),
              leading: const Icon(Icons.computer),
            ),
            ListTile(
              title: const Text('Date'),
              subtitle: Text(date),
              leading: const Icon(Icons.calendar_today),
            ),
            ListTile(
              title: const Text('Browser Name'),
              subtitle: Text(browserName),
              leading: const Icon(Icons.web),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: onPre,
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}


class SendNotificationPopup extends StatelessWidget {
  final String systemName;
  final String browserName;

  const SendNotificationPopup({
    required this.systemName,
    required this.browserName,
  });

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
          Text(
            'System: $systemName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Browser: $browserName',
            style: const TextStyle(
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


