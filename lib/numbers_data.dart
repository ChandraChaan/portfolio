import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumbersData extends StatefulWidget {
  const NumbersData({super.key});

  @override
  State<NumbersData> createState() => _NumbersDataState();
}

class _NumbersDataState extends State<NumbersData> {
  String? num;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('deviceId') != null) {
      num = prefs.getString('deviceId')!;
    } else {
      prefs.setString('deviceId', '1');
      num = '2';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(num.toString())),
    );
  }
}
