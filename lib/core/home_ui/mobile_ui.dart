import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../common/drawer_ui.dart';
import '../common/scroll.dart';

class MobileHomeUI extends StatelessWidget {
  const MobileHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   children: [
      //     scrolIndicator(),
      //     Expanded(
      //       child: Scaffold(
      //         backgroundColor: Theme.of(context).cardColor,
      //         appBar: AppBar(
      //           backgroundColor: Colors.transparent,
      //           elevation: 0.0,
      //           iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      //         ),
      //         drawer: drawerMobile(context),
      //         body: SingleChildScrollView(
      //           controller: _scrollController,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               VisibilityDetector(
      //                 key: aboutScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = true;
      //                       _isExpVisible = false;
      //                       _isPortfoVisible = false;
      //                       _isSkillsVisible = false;
      //                       _isProjectsVisible = false;
      //                       _isContactVisible = false;
      //                     });
      //                   }
      //                 },
      //                 child: const About(
      //                   mobileImg: true,
      //                 ),
      //               ),
      //               VisibilityDetector(
      //                 key: expScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = false;
      //                       _isExpVisible = true;
      //                       _isPortfoVisible = false;
      //                       _isSkillsVisible = false;
      //                       _isProjectsVisible = false;
      //                       _isContactVisible = false;
      //                     });
      //                   }
      //                 },
      //                 child: const Experience(
      //                   smallCard: true,
      //                 ),
      //               ),
      //               VisibilityDetector(
      //                 key: portfoScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = false;
      //                       _isExpVisible = false;
      //                       _isPortfoVisible = true;
      //                       _isSkillsVisible = false;
      //                       _isProjectsVisible = false;
      //                       _isContactVisible = false;
      //                     });
      //                   }
      //                 },
      //                 child: const Portfolio(
      //                   smallCard: true,
      //                 ),
      //               ),
      //               VisibilityDetector(
      //                 key: skillScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = false;
      //                       _isExpVisible = false;
      //                       _isPortfoVisible = false;
      //                       _isSkillsVisible = true;
      //                       _isProjectsVisible = false;
      //                       _isContactVisible = false;
      //                     });
      //                   }
      //                 },
      //                 child: const Skills(),
      //               ),
      //               VisibilityDetector(
      //                 key: projectsScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = false;
      //                       _isExpVisible = false;
      //                       _isPortfoVisible = false;
      //                       _isSkillsVisible = false;
      //                       _isProjectsVisible = true;
      //                       _isContactVisible = false;
      //                     });
      //                   }
      //                 },
      //                 child: const Projects(
      //                   smallCard: true,
      //                 ),
      //               ),
      //               VisibilityDetector(
      //                 key: contactScrollKey,
      //                 onVisibilityChanged: (visibilityInfo) {
      //                   if (visibilityInfo.visibleFraction == 1) {
      //                     setState(() {
      //                       _isAboutVisible = false;
      //                       _isExpVisible = false;
      //                       _isPortfoVisible = false;
      //                       _isSkillsVisible = false;
      //                       _isProjectsVisible = false;
      //                       _isContactVisible = true;
      //                     });
      //                   }
      //                 },
      //                 child: const Contact(
      //                   isWeb: false,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
