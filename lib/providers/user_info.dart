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
  List<Map<String,dynamic>> expData = [
    {
      "icon":"icon",
      "title":"Senior Web Developer",
      "summary":"im very waste fello....i dont have sence...im an ediot",
      "startDate":"march 2020 - ",
      "endDate":"april 2020",
      "present": false,
    },


  ];
List<Map<String,dynamic>> expData1 = [
  {
    "icon1":"icon",
    "title1":"Web Developer",
    "summary1":"im very waste fello....i dont have sence...im an ediot",
    "startDate1":"December 2020 ",
    "endDate1":"- april 2020",
    "present1": false,
  },


];
List<Map<String,dynamic>> expData2 = [
  {
    "icon2":"icon",
    "title2":"Junior Web Designer",
    "summary2":"im very waste fello....i dont have sence...im an ediot",
    "startDate2":"July 2017 ",
    "endDate2":"- December 2018",
    "present2": false,
  },


];
List<Map<String,dynamic>> expData3 = [
  {
    "icon3":"FontAwesomeIcons.images",
    "title3":"Web Design Inter",
    "summary3":"im very waste fello....i dont have sence...im an ediot",
    "startDate3":"July 2017 ",
    "endDate3":"- December 2018",
    "present3": false,
  },


];



}