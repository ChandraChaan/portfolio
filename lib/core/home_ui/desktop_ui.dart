import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../providers/user_info.dart';
import '../../utils/font_style.dart';
import '../../utils/settings_popup.dart';
import '../common/scroll.dart';

class DesktopHomeUI extends StatelessWidget {
  const DesktopHomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Consumer<UserInfo>(builder: (context, provider, child) {
          return Column(
            children: [
              const ScrollIndicator(),
              Expanded(
                child: Row(
                  children: [
                    // side menu
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).indicatorColor,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const LunchSettings(),
                            Container(
                              height: 160,
                              width: 140,
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Center(
                                child: Container(
                                    height: 150,
                                    width: 130,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/profile.jpg"),
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            for (int a = 0;
                                a < provider.menuList.length;
                                a++) ...[
                              TextButton(
                                onPressed: () {
                                  scrollSmooth(provider
                                      .scrollKeyValue(a)
                                      .currentContext!);
                                },
                                child: CommonText(
                                    text: '${provider.menuList[a]['name']}'
                                        .toUpperCase(),
                                    color: provider.menuList[a]['visibility']
                                        ? (Theme.of(context).focusColor)
                                        : null),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                    // body
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        controller: provider.scrollController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int a = 0; a < provider.menuList.length; a++)
                              VisibilityDetector(
                                key: provider.scrollKeyValue(a),
                                onVisibilityChanged: (visibilityInfo) {
                                  if (visibilityInfo.visibleFraction == 1) {
                                    provider.updateVisibility(a);
                                  }
                                },
                                child: provider.menuList[a]['widget'],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
