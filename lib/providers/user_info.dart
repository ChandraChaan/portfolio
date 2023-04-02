import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier {
  String user = 'Chandra Obul Reddy';
  String userFirstName = '';
  String smallTagline = 'THE NEXT BIG IDEA IS WAITING FOR ITS NEXT BIG CHANGER WITH THEMSBIT';
  String bigTagline = 'I am experienced in leveraging agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition';

  bool userDeatile(String? text) {
    user = text ?? 'User';
    if (user.split(' ').length > 1) {
      return false;
    } else {
      return true;
    }
  }

  // it will remove last name for highlighting it on UI
  removeLastNameOnUser() {
    List name = user.split(' ');

    if (name.length > 1) {
      name.removeRange(name.length - 1, name.length);
      userFirstName = name.join(' ');
    }
    userFirstName = name.join(' ');
  }


  List<Map<String, dynamic>> expData = [
    {
      "icon": "icon",
      "title": "Senior Web Developer",
      "summary": "im very waste fello....i dont have sence...im an ediot",
      "startDate": "march 2020 - ",
      "endDate": "april 2020",
      "present": false,
    },
    {
      "icon": "icon",
      "title": "Senior Web Developer",
      "summary": "im very waste fello....i dont have sence...im an ediot",
      "startDate": "march 2020 - ",
      "endDate": "april 2020",
      "present": false,
    },
    {
      "icon": "icon",
      "title": "Senior Web Developer",
      "summary": "im very waste fello....i dont have sence...im an ediot",
      "startDate": "march 2020 - ",
      "endDate": "april 2020",
      "present": false,
    },
    {
      "icon": "icon",
      "title": "Senior Web Developer",
      "summary": "im very waste fello....i dont have sence...im an ediot",
      "startDate": "march 2020 - ",
      "endDate": "april 2020",
      "present": false,
    },
    {
      "icon": "icon",
      "title": "Senior Web Developer",
      "summary": "im very waste fello....i dont have sence...im an ediot",
      "startDate": "march 2020 - ",
      "endDate": "april 2020",
      "present": false,
    },
  ];


  List<Map<String, dynamic>> skillData = [
    {
      "name": "Flutter",
      "score": "44%",
    },
    {
      "name": "Java",
      "score": "24%",
    },
    {
      "name": "Dart",
      "score": "54%",
    },
    {
      "name": "Android",
      "score": "94%",
    },
    {
      "name": "HTML",
      "score": "74%",
    },
  ];

}
