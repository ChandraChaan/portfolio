import 'package:flutter/material.dart';

class AdminData extends StatelessWidget {
  const AdminData({Key? key}) : super(key: key);

  void showNotificationPopup(BuildContext context, String recipientName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SendNotificationPopup(systemName: 'Mac', browserName: 'Chrome',);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return  UserDataScreen(
            address: '123 Main St',
            systemName: 'Flutter App',
            date: 'May 25, 2023',
            browserName: 'Chrome',
            onPre: (){
              showNotificationPopup(context, 'John Doe');
            },

          );
        },
      ),
    );
  }
}

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


