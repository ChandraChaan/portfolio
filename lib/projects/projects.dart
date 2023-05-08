import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Projects extends StatelessWidget {
  final bool smallCard;

  const Projects({super.key, required this.smallCard});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        provider.imagesListModifiying();
        return Container(
          color:Theme.of(context).backgroundColor,

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: (100),
                ),
                getTextStyle("Projects", FontWeight.bold, Theme.of(context).primaryColor,
                    50),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: (6),
                  width: (120),
                  color: Colors.blue,
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
                                  color:Theme.of(context).cardColor,
                                  border: Border.all(color:provider.themeColor)
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.projectsData[a]['title']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['date']}",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['summary']}",
                                      style: GoogleFonts.abyssinicaSil(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 19),
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
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
                                  color:Theme.of(context).cardColor,
                                  border: Border.all(color:provider.themeColor)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.projectsData[a]['title']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['date']}",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['summary']}",
                                      style: GoogleFonts.abyssinicaSil(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 19),
                                      ),
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
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
                                  color:Theme.of(context).cardColor,
                                  border: Border.all(color:provider.themeColor)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.projectsData[a]['title']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['date']}",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${provider.projectsData[a]['summary']}",
                                      style: GoogleFonts.abyssinicaSil(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 19),
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
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
