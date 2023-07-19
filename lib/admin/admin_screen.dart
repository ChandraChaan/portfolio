import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfoli_web/admin/send_notification.dart';
import 'package:portfoli_web/admin/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../providers/user_repo.dart';

class AdminData extends StatefulWidget {
  const AdminData({Key? key}) : super(key: key);

  @override
  State<AdminData> createState() => _AdminDataState();
}

class _AdminDataState extends State<AdminData> {
  CollectionReference visitorsCollection =
      FirebaseFirestore.instance.collection('visitors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).indicatorColor,
        centerTitle: true,
        title: const Text('User Data', style: FontStyles.heading5,),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            visitorsCollection.orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final sortedDocs = snapshot.data!.docs;
          final userDataList = sortedDocs.map((DocumentSnapshot document) {
            final userRecord = UserRecord.fromSnapshot(document);
            return UserDataScreen(
              address: userRecord.address,
              deviceType: userRecord.deviceTypeName,
              deviceRam: '${userRecord.deviceMemory ?? '0'}',
              systemName: userRecord.systemName,
              date: formatDate(userRecord.date),
              browserName: userRecord.browserName,
              tokenFcm: '',
              battery: userRecord.batteryStatus,
              wifi: userRecord.wifiNetworkStatus,
              sound: userRecord.musicMode ? 'true' : 'false',
              darkTheme: userRecord.themeLightMode ? 'false' : 'true',
              colorTheme: userRecord.themeStringColor,
              seenChatScreen: userRecord.seenChatScreen,
              seenFullResume: userRecord.seenFullResume,
              seenAdminScreen: userRecord.seenAdminScreen,
              onPre: () {
                // showNotificationPopup(context, userRecord.tokenFcm);
              },
            );
          }).toList();

          return ListView(
            shrinkWrap: true,
            children: userDataList,
          );
        },
      ),
    );
  }

  void showNotificationPopup(BuildContext context, String tokenF) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SendNotificationPopup(ftkn: tokenF);
      },
    );
  }

  String formatDate(String dateTimeString) {
    if (dateTimeString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('h:mm a - EEEE, MMMM d, y').format(dateTime);
    }
    return '';
  }
}
