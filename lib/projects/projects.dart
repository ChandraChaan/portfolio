import 'package:flutter/material.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:portfoli_web/utils/headLine.dart';
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
                const HeadLineText(heading: 'PROJECTS'),
                for (int a = 0; a < provider.projectsData.length; a++)
                  smallCard
                      ? timelineWidget(context,
                          title: "${provider.projectsData[a]['title']}",
                          summary: "${provider.projectsData[a]['summary']}",
                          date: "${provider.projectsData[a]['date']}",
                          isStartChild: false,
                          singleElement: true)
                      : timelineWidget(
                          context,
                          title: "${provider.projectsData[a]['title']}",
                          summary: "${provider.projectsData[a]['summary']}",
                          date: "${provider.projectsData[a]['date']}",
                          isStartChild: a.isOdd ? false : true,
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

  Widget timelineWidget(BuildContext context,
      {required String title,
      required String summary,
      required String date,
      required bool isStartChild,
      bool singleElement = false}) {
    return TimelineTile(
      alignment: singleElement ? TimelineAlign.start : TimelineAlign.center,
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(2),
        indicator: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).indicatorColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.folder,
              // isStartChild? Icons.web : Icons.mobile_screen_share,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).indicatorColor,
        thickness: 2.0,
      ),
      afterLineStyle: LineStyle(
        color: Theme.of(context).indicatorColor,
        thickness: 2.0,
      ),
      startChild: isStartChild
          ? childElement(
              context,
              title: title,
              summery: summary,
              date: date,
              isStartChild: isStartChild,
            )
          : null,
      endChild: !isStartChild
          ? childElement(
              context,
              title: title,
              summery: summary,
              date: date,
              isStartChild: isStartChild,
              textAlignLeft: true,
            )
          : null,
    );
  }

  Widget childElement(BuildContext context,
      {required String title,
      required String summery,
      required String date,
      required bool isStartChild,
      bool textAlignLeft = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: Theme.of(context).indicatorColor)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: isStartChild
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: title,
                textAlign: textAlignLeft ? TextAlign.left : TextAlign.right,
                style: FontStyles.heading5,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonText(
                text: date,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonText(
                text: summery,
                style: FontStyles.caption,
                textAlign: isStartChild ? TextAlign.right : TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
