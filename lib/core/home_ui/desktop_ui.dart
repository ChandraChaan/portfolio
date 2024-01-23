import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../providers/user_info.dart';
import '../../utils/constants.dart';
import '../common/drawer_ui.dart';

class DesktopHomeUI extends StatelessWidget {
  const DesktopHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        children: [
          // Side menu
          const Expanded(
            flex: 1,
            child: SideBarUI(),
          ),
          // Body
          Expanded(
            flex: 4,
            child: Consumer<UserInfo>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  controller: provider.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int index = 0; index < Constants.desktopMenuList.length; index++)
                        VisibilityDetector(
                          key: provider.scrollKeyValue(index),
                          onVisibilityChanged: (visibilityInfo) {
                            if (visibilityInfo.visibleFraction == 1) {
                              provider.updateVisibility(index);
                            }
                          },
                          child: Constants.desktopMenuList[index],
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
