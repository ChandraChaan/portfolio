
import '../../about/about.dart';
import '../../contact/contact.dart';
import '../../experience/experience.dart';
import '../../portfolio/portfolio.dart';
import '../../projects/projects.dart';
import '../../skills/skills.dart';

class Constants {
// the sidebar elements
  List<Map<String, dynamic>> mobileMenuList = [
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
  List<Map<String, dynamic>> tabMenuList = [
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
  List<Map<String, dynamic>> desktopMenuList = [
    {
      'name': 'About',
      'visibility': true,
      'widget': const About()
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
        isWeb: true,
      )
    },
  ];

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
