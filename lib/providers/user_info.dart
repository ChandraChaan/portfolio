import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier{
String user = 'user';

  bool userDeatile(String? text) {
    user = text ?? 'user';
    if(user.split(' ').length > 1){
      return false;
    }else{
      return true;
    }
  }

}