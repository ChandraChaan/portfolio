import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:portfoli_web/admin/send_notification.dart';
import 'package:portfoli_web/admin/user_data.dart';
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

  void showNotificationPopup(BuildContext context, String tokenF) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SendNotificationPopup(ftkn: tokenF,);
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

          final sortedDocs = snapshot.data!.docs..sort((a, b) {
            final aDateString = (a.data() as Map<String, dynamic>)['date'] as String?;
            final bDateString = (b.data() as Map<String, dynamic>)['date'] as String?;
            final aDate = aDateString != null ? DateTime.parse(aDateString) : DateTime.now();
            final bDate = bDateString != null ? DateTime.parse(bDateString) : DateTime.now();
            return bDate.compareTo(aDate);
          });

          return ListView(
            children: sortedDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;

              String formattedDate =
              formatDate(data['date'] ?? DateTime.now().toString());
              return UserDataScreen(
                address: data['address'] ?? '',
                systemName: data['system_name'] ?? '',
                date: formattedDate,
                browserName: data['browser_name'] ?? '',
                tokenFcm: data['token_fcm'].toString(),
                battery: data['battery'] ?? '',
                wifi: data['wifi'] ?? '',
                sound: data['sound'].toString(),
                darkTheme: data['dark_theme'].toString(),
                colorTheme: data['color_theme'] ?? '',
                seenChatScreen: data['seen_chat_screen'] ?? '',
                seenFullResume: data['seen_full_resume'] ?? '',
                onPre: () {
                  showNotificationPopup(context, data['token_fcm'].toString());
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }


  String formatDate(String dateTimeString) {
    if (dateTimeString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('EEEE, MMMM d, y - h:mm a').format(dateTime);
    }
    return '';
  }
}

