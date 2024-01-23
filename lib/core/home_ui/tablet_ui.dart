import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../providers/user_info.dart';
import '../../utils/constants.dart';
import '../common/drawer_ui.dart';

class TabletHomeUI extends StatelessWidget {
  const TabletHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserInfo>(builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          ),
          drawer: drawerMobile(context),
          body: SingleChildScrollView(
            controller:
                Provider.of<UserInfo>(context, listen: false).scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int a = 0; a < Constants.tabMenuList.length; a++)
                  VisibilityDetector(
                    key: provider.scrollKeyValue(a),
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction == 1) {
                        provider.updateVisibility(a);
                      }
                    },
                    child: Constants.tabMenuList[a],
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
