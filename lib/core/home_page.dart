import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'home_ui/desktop_ui.dart';
import 'home_ui/mobile_ui.dart';
import 'home_ui/tablet_ui.dart';

class HomePage extends StatelessWidget {

  // int notificationCount = 0;

  const HomePage({super.key});

  // showDeniedPopUp() {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Permission Disabled'),
  //         content: const Text('Notification permission has been disabled'),
  //         actions: [
  //           TextButton(
  //             child: const Text('Ask Again'),
  //             onPressed: () async {
  //               await Provider.of<UserInfo>(context, listen: false)
  //                   .getPermission();
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Close'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               // Perform any additional logic or call your provider method to close the application.
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // sendNotificationThis() {
  //   if (Provider.of<UserInfo>(context, listen: false).grantedPermission != 1) {
  //     showDeniedPopUp();
  //   } else {
  //     Provider.of<UserInfo>(context, listen: false).sendNotification();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: MobileHomeUI(),
      tablet: TabletHomeUI(),
      desktop: DesktopHomeUI(),
    );
  }

}
