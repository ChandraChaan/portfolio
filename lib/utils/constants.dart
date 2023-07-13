import 'package:flutter/material.dart';

import '../../about/about.dart';
import '../../contact/contact.dart';
import '../../experience/experience.dart';
import '../../portfolio/portfolio.dart';
import '../../projects/projects.dart';
import '../../skills/skills.dart';

class Constants {
// the sidebar elements
  static List<Map<String, dynamic>> mobileMenuList = [
    {
      'name': 'About',
      'visibility': true,
      'widget': const About(
        mobileImg: true,
      )
    },
    {
      'name': 'Experience',
      'visibility': false,
      'widget': const Experience(
        smallCard: true,
      )
    },
    {
      'name': 'Portfolio',
      'visibility': false,
      'widget': const Portfolio(
        smallCard: true,
      )
    },
    {'name': 'Skills', 'visibility': false, 'widget': const Skills()},
    {
      'name': 'Projects',
      'visibility': false,
      'widget': const Projects(
        smallCard: true,
      )
    },
    {
      'name': 'Contact',
      'visibility': false,
      'widget': const Contact(
        isWeb: false,
      )
    },
  ];
  static List<Map<String, dynamic>> tabMenuList = [
    {
      'name': 'About',
      'visibility': true,
      'widget': const About(
        mobileImg: true,
        tabImg: true,
      )
    },
    {
      'name': 'Experience',
      'visibility': false,
      'widget': const Experience(
        smallCard: false,
      )
    },
    {
      'name': 'Portfolio',
      'visibility': false,
      'widget': const Portfolio(
        smallCard: false,
      )
    },
    {'name': 'Skills', 'visibility': false, 'widget': const Skills()},
    {
      'name': 'Projects',
      'visibility': false,
      'widget': const Projects(
        smallCard: false,
      )
    },
    {
      'name': 'Contact',
      'visibility': false,
      'widget': const Contact(
        isWeb: false,
      )
    },
  ];
  static List<Map<String, dynamic>> desktopMenuList = [
    {'name': 'About', 'visibility': true, 'widget': const About()},
    {
      'name': 'Experience',
      'visibility': false,
      'widget': const Experience(
        smallCard: false,
      )
    },
    {
      'name': 'Portfolio',
      'visibility': false,
      'widget': const Portfolio(
        smallCard: false,
      )
    },
    {'name': 'Skills', 'visibility': false, 'widget': const Skills()},
    {
      'name': 'Projects',
      'visibility': false,
      'widget': const Projects(
        smallCard: false,
      )
    },
    {
      'name': 'Contact',
      'visibility': false,
      'widget': const Contact(
        isWeb: true,
      )
    },
  ];

  static List<Map<String, dynamic>> expData = [
    {
      "icon": Icons.laptop_outlined,
      "title": "Senior Software Developer",
      "summary":
          "As an experienced Flutter Web Developer at Softdel Systems, I specialize in responsive web design, PWAs, and Provider state management. With a strong focus on Flutter Web 3.0, I excel at creating stunning and fully responsive web designs, ensuring exceptional user experiences across various platforms. My expertise lies in implementing responsive UI solutions that seamlessly adapt to mobile, tablet, and desktop web environments. I am skilled at integrating Progressive Web App (PWA) features, allowing for offline functionality, push notifications, and an immersive user experience akin to native mobile apps. To optimize performance and maintainability, I rely on the efficient Provider state management architecture for effective state handling and communication between different components of the application. Additionally, I have successfully developed visually appealing graphs and charts, elevating data visualization and making complex information easily digestible for users. My passion for delivering exceptional Flutter Web experiences drives me to stay updated with the latest industry trends and best practices.",
      "startDate": "June 2022",
      "endDate": "",
      "present": true,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Senior Mobile App Developer",
      "summary":
          "I firmly believe that great leadership is the key to unlocking extraordinary results. As an accomplished Team Leader specializing in Flutter mobile app development, I have successfully utilized the Flutter framework, along with technologies such as Getx and Bloc, to deliver exceptional outcomes. With expertise in creating dynamic and engaging user interfaces, seamless API integration, and integration of popular payment gateways, I prioritize clean, maintainable, and scalable codebases to reduce development time and costs. I have a proven track record of delivering high-quality solutions for various platforms, including Flutter web, Android, and iOS, within tight deadlines. Collaborating with my exceptional team and leveraging the power of Flutter, we consistently achieve remarkable productivity and efficiency, driving success in our projects.",
      "startDate": "Feb 2021",
      "endDate": "June 2022",
      "present": false,
    },
    {
      "icon": Icons.laptop_outlined,
      "title": "Software Developer",
      "summary":
          "I am an accomplished Full-Stack Developer with expertise in web and mobile app development. I specialize in CodeIgniter, Flutter, and RESTful APIs. Throughout my career, I have consistently delivered high-quality projects using diverse technologies. I create visually appealing and user-friendly interfaces using HTML, CSS, JavaScript, jQuery, Ajax, and Bootstrap. I develop robust and scalable web applications using CodeIgniter and expand into Flutter for cross-platform mobile app development. I excel in efficient data management with MySQL and Firebase databases, and I have a strong skillset in developing RESTful APIs for seamless communication and integration.",
      "startDate": "Feb 2018",
      "endDate": "Jan 2021",
      "present": false,
    },
  ];

  static List<Map<String, dynamic>> projectsData = [
    {
      'title': 'Lochinvar',
      'date': 'Jun 2022',
      'summary':
          'This is boiler app , using this app, we can control the boiler from everywhere, this is very use full app, here iam doing Kotlin app to flutter app conversation for Web and Mobile hybrid code, here I used flutter and provider state management.'
    },
    {
      'title': 'Sunstone hub',
      'date': 'Jan 2022',
      'summary':
          'This is University app, there students will do attendance, and books, fees etc I developed here fee module. With Getx state management, flutter.'
    },
    {
      'title': 'People first Platform',
      'date': 'February 2021',
      'summary':
          'Here we are using DDD architecture with Getx, bloc, and cubit, in that architecture infrastructure'
              'domain, application presentation layers we maintain here, and network layer also.'
    },
    {
      'title': 'Ferry App',
      'date': 'April 2021',
      'summary':
          'Here common network Layer I’m using here and it will show you the check-in process for airplane journey users.'
    },
    {
      'title': 'EstreetMart - Singapore online shopping website',
      'date': 'May 2021',
      'summary':
          'Here I’m using DDD architecture with GetX, and this is the web, tablet, mobile, and desktop also'
              'multiple designs with the same functionality and this is a large project here IMS, CMS, and this one is there.'
    },
    {
      'title': 'Skadaddle Online Sports activity App',
      'date': 'June 2021',
      'summary':
          'Here I’m using DDD architecture with GetX, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'RandAc app - Online Book Technician for AC Repairing',
      'date': 'September 2021',
      'summary':
          'This is an ac repairing app, this is currently what we are developing Here I’m using DDD architecture with Getx, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'GastroCare -Online Doctor consultation Booking App',
      'date': 'August 2021',
      'summary':
          'This is a Medical app, this is currently we are developing Here I’m using Bloc, Providers, this is a mobile app here we are used zoom video calling functionality for doctor consultation.'
    },
    {
      'title': 'Plus Pin Pharma -Online Medical Store',
      'date': 'August 2021',
      'summary':
          'This is a Medical Store app, this is currently 3members are developing Here I’m using MVC architecture with Bloc and GetX, this is a mobile app with only excellent UI and better functionality.'
    },
    {
      'title': 'Food Delivery App',
      'date': 'February 2020',
      'summary': 'This is a food delivery app using flutter.'
    },
    {
      'title': 'Online shopping web & mobile application',
      'date': 'January 2019',
      'summary':
          'This is a flutter platform-based online shopping service, food, clothes, and etc. so many services are there, for the web, we are using PHP Laravel and fronted bootstrap, jQuery.'
    },
    {
      'title': 'School management system',
      'date': 'May 2019',
      'summary':
          'It is a flutter Mobile application. This application is very useful for schools, This application has a fee management system and HR and payroll and online classes and online exams and so many services there,'
    },
  ];

  static List<Map<String, dynamic>> skillData = [
    {
      "name": "Flutter",
      "score": "96%",
      "icon": "assets/skills/flutter.png",
    },
    {
      "name": "Java",
      "score": "63%",
      "icon": "assets/skills/java.png",
    },
    {
      "name": "Dart",
      "score": "98%",
      "icon": "assets/skills/dart.png",
    },
    {
      "name": "JavaScript",
      "score": "54%",
      "icon": "assets/skills/js.png",
    },
    {
      "name": "HTML",
      "score": "74%",
      "icon": "assets/skills/html.png",
    },
    {
      "name": "CSS",
      "score": "61%",
      "icon": "assets/skills/css.png",
    },
    {
      "name": "FIREBASE",
      "score": "74%",
      "icon": "assets/skills/firebase.png",
    },
    {
      "name": "PYTHON",
      "score": "51%",
      "icon": "assets/skills/python.png",
    },
    {
      "name": "PHP",
      "score": "94%",
      "icon": "assets/skills/php.png",
    },
  ];

  static Map<String, dynamic> imagesMap = {
    'all': [],
    'mobile ui': [
      {
        'thumb-line': 'assets/portfolio/arrton1.png',
        'caption': 'Arrton',
        'img': [
          for (int a = 1; a <= 4; a++) 'assets/portfolio/arrton$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/arrton_d1.png',
        'caption': 'Arrton-Mobile App',
        'img': [
          for (int a = 1; a <= 3; a++) 'assets/portfolio/arrton_d$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/arrton_m1.png',
        'caption': 'Arrton-merchant App',
        'img': [
          for (int a = 1; a <= 6; a++) 'assets/portfolio/arrton_m$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/ferry1.png',
        'caption': 'Ferry App',
        'img': [
          for (int a = 1; a <= 4; a++) 'assets/portfolio/ferry$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/ppl1.png',
        'caption': 'People Platform App',
        'img': [
          for (int a = 1; a <= 6; a++) 'assets/portfolio/ppl$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/skedal1.png',
        'caption': 'Skadle App',
        'img': [
          for (int a = 1; a <= 38; a++) 'assets/portfolio/skedal$a.png',
        ]
      },
      {
        'thumb-line': 'assets/portfolio/sunstone1.png',
        'caption': 'Sunstone App',
        'img': [
          for (int a = 1; a <= 17; a++) 'assets/portfolio/sunstone$a.png',
        ]
      },
    ],
    'PWA': [
      {
        'thumb-line': 'assets/portfolio/edecofy1.png',
        'caption': 'Edecofy',
        'img': [
          for (int a = 1; a <= 11; a++) 'assets/portfolio/edecofy$a.png',
        ]
      },
    ],
  };

  static String smallTagline =
      'Senior Software Engineer | Flutter & Flutter Web 3.0 Specialist | Building High-Performance Cross-Platform and Web Applications';
  static String bigTagline =
      'Experienced Senior Software Engineer with 5.5 years of total experience, including 1.5 years of full-stack expertise and 4 years focused on Flutter development. Passionate about creating innovative mobile applications, I have successfully delivered 12+ projects across various domains. Specializing in robust e-commerce solutions, Google Maps integration, HR management systems, and educational and hospitality projects, I excel in delivering seamless user experiences, optimizing performance, and integrating complex functionalities. A collaborative problem-solver, I thrive on challenges and exceed client expectations by leveraging emerging technologies and staying up-to-date with industry trends. With strong communication and analytical skills, I translate complex requirements into actionable plans and consistently deliver results within deadlines. Committed to continuous learning and growth, I actively seek opportunities to expand my knowledge and skill set.';

}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}

double calculateAspectRatio(String imageUrl) {
  // Perform image loading and calculate aspect ratio
  // You can use your preferred method or library to load the image and retrieve its dimensions
  // For simplicity, this example uses the width and height directly

  // Replace the code below with your actual image loading and dimension retrieval logic
  double imageWidth = 800.0;
  double imageHeight = 600.0;

  return imageWidth / imageHeight;
}
