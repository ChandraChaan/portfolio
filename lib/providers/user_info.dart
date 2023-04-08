import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier {
  String user = 'Chandra Obul Reddy';
  String userFirstName = '';
  String smallTagline =
      'THE NEXT BIG IDEA IS WAITING FOR ITS NEXT BIG CHANGER WITH THEMSELF';
  String bigTagline =
      'I am experienced in leveraging agile frameworks to provide a robust synopsis '
      'for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking '
      'to further the overall value proposition';

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
    for (int i = 0; i < 5; i++)
      {
        "icon": Icons.laptop_outlined,
        "title": "Full Stack Developer",
        "summary":
            "Dedicated and efficient full stack developer with 6+ years experience in application layers, presentation layers, and databases. Certified in both F/E and B/E technologies. Spearheaded successful transition from LAMP stack to MEAN which cut latency by 40% and increased effectiveness of database administrators by 20%. Seeking to further improve HTML5 and CSS3 skills as the future full stack developer at Atmospheric Solutions.",
        "startDate": "March 2020",
        "endDate": "April 2022",
        "present": i == 0 ? true : false,
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

  Map imagesMap = {
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
  }

  imageFilter(String typ) {
    print('add filter to $typ');
    pImages.where((o) => o['type'] == typ).toList();
    print(pImages.toString());
  }
}
