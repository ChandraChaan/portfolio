import 'package:flutter/material.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../providers/user_info.dart';

class Projects extends StatelessWidget {
  final bool smallCard;

  const Projects({super.key, required this.smallCard});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: (100),
                ),
                const CommonText(
                  text: "Projects",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: (6),
                  width: (120),
                  color: Theme.of(context).indicatorColor,
                ),
                const SizedBox(
                  height: 70.0,
                ),
                for (int a = 0; a < provider.projectsData.length; a++)
                  smallCard
                      ? TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0.2,
                          endChild: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border:
                                      Border.all(color: provider.themeColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text:
                                          "${provider.projectsData[a]['title']}",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CommonText(
                                      text:
                                          "${provider.projectsData[a]['date']}",
                                      fontSize: 9,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CommonText(
                                      text:
                                          "${provider.projectsData[a]['summary']}",
                                      fontSize: 5,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : TimelineTile(
                          alignment: TimelineAlign.center,
                          lineXY: 0.2,
                          startChild: a.isEven
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(
                                            color: provider.themeColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['title']}",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['date']}",
                                            fontSize: 8,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['summary']}",
                                            fontSize: 5,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                          endChild: a.isOdd
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(
                                            color: provider.themeColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['title']}",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['date']}",
                                            fontSize: 9,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CommonText(
                                            text:
                                                "${provider.projectsData[a]['summary']}",
                                            fontSize: 5,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
