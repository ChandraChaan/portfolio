import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier{
  String _name='No name';
  String _age='0';
  String get age=>_age;
  String get name=>_name;
  userDeatile(String username,String userage){
    _name=username;
    _age=userage;
    notifyListeners();
  }
}