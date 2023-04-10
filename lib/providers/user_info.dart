import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier {
  String user = 'Chandra Obul Reddy';
  String userFirstName = '';
  String imageFilterString = 'all';
  bool imageLoaded = false;
  String smallTagline =
      'THE NEXT BIG IDEA IS WAITING FOR ITS NEXT BIG CHANGER WITH THEMSELF';
  String bigTagline = 'I have a total of around 4.6 years of experience,'
      'recently, with FLUTTER, I\'m developed multiple projects. I believe my'
      'professional skill set and my previous experience working as a Full-Stack and'
      'senior flutter developer could make me a valuable asset to your organization,'
      ' so I am writing to inform you of my interest in pursuing a career at org name';

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
      "icon": Icons.laptop_outlined,
      "title": "Senior Mobile App Developer",
      "summary": "Here I am team lead, we are working on sprint wise features, and DDD"
          "architecture and GetX, Bloc, providers state management we are using. Kotlin"
          "  for android native payment integration purpose we are used. Swift for IOS"
          "Native feature development we are used."
          "Flutter web also we are done here, flutter web very fast code, functionality will"
          "be same mobile and web, UI will do difference so fast code we will make for"
          "flutter web",
      "startDate": "Feb 2021",
      "endDate": "",
      "present": true,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Software Developer",
      "summary": "I'm Full Stack developer at this company and"
          "We are using framework CodeIgniter, PHP frameworks for backend, and we"
          "are using for mobile development in flutter, and we are using jQuery, JS,"
          "bootstrap for frontend."
          "This is product base company"
          "Maintained integrity of general ledger, including the chart of accounts",
      "startDate": "Feb 2018",
      "endDate": "Jan 2021",
      "present": false,
    },
  ];

  List<Map<String, dynamic>> skillData = [
    {
      "name": "Flutter",
      "score": "100%",
    },
    {
      "name": "Java",
      "score": "80%",
    },
    {
      "name": "Dart",
      "score": "100%",
    },
    {
      "name": "JavaScript",
      "score": "94%",
    },
    {
      "name": "HTML",
      "score": "74%",
    },
    {
      "name": "FIREBASE",
      "score": "74%",
    },
    {
      "name": "PYTHON",
      "score": "84%",
    },
    {
      "name": "PHP",
      "score": "94%",
    },
    {
      "name": "HTML",
      "score": "74%",
    },
  ];

  Map imagesMap = {
    'all': [],
    'ntr': [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg/1024px-N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg/1024px-N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg/1024px-N.T.Rama_Rao_Jr._at_the_RRR_Press_Meet_in_Chennai.jpg',
    ],
    'ram': [
      'https://static.toiimg.com/thumb/75733242.cms?width=680&height=512&imgsize=1099096',
      'https://static.toiimg.com/thumb/msid-92543510,imgsize-48774,width-800,height-600,resizemode-75/92543510.jpg'
    ],
  };
  List imagesKeys = [];
  List pImages = [];

  imagesListModifiying() {
    imageLoaded = false;
    imagesKeys.clear();
    pImages.clear();
    imagesKeys = imagesMap.keys.toList();
    for (int a = 0; a < imagesKeys.length; a++) {
      for (int i = 0; i < imagesMap[imagesKeys[a]].length; i++) {
        pImages.add({
          'img': '${imagesMap[imagesKeys[a]][i]}',
          'type': '${imagesKeys[a]}'
        });
      }
    }
    imageLoaded = true;
  }

  imageFilter(String typ) {
    imageLoaded = false;
    print('add filter to $typ');
    imageFilterString = typ;
    pImages = pImages.where((o) => o['type'] == typ).toList();
    imageLoaded = true;
    notifyListeners();
  }
}
