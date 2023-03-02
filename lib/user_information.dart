import 'package:flutter/material.dart';
import 'package:originalmorals/providers/user_info.dart';
import 'package:provider/provider.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [

          Text(context.watch<UserInfo>().name.toString()),
          Text('Age : '+context.watch<UserInfo>().age.toString()),
          Text('skill : html ,css, javascript'),
        ],
      ),),
    );
  }
}
