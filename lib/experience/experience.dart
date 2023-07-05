import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfoli_web/utils/headLine.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Experience extends StatelessWidget {
  final bool smallCard;

  const Experience({super.key, required this.smallCard});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Column(children: [
          const HeadLineText(heading: 'EXPERIENCE'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: smallCard
                ? ListView.builder(
                    itemCount: provider.expData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cardItem(
                            context: context,
                            iconName: provider.expData[index]["icon"],
                            title: "${provider.expData[index]["title"]}",
                            summery: "${provider.expData[index]["summary"]}",
                            startDate:
                                "${provider.expData[index]["startDate"]}",
                            endDate:
                                " - ${provider.expData[index]["present"] != true ? provider.expData[index]["endDate"] : 'Present'}"),
                      );
                    })
                : GridView.builder(
                    itemCount: provider.expData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.0,
                            childAspectRatio: 1.56,
                            mainAxisSpacing: 18.0),
                    itemBuilder: (BuildContext context, int index) {
                      return cardItem(
                          context: context,
                          iconName: provider.expData[index]["icon"],
                          title: "${provider.expData[index]["title"]}",
                          summery: "${provider.expData[index]["summary"]}",
                          startDate: "${provider.expData[index]["startDate"]}",
                          endDate:
                              " - ${provider.expData[index]["present"] != true ? provider.expData[index]["endDate"] : 'Present'}");
                    },
                  ),
          ),
          const SizedBox(
            height: 50,
          ),
        ]);
      },
    );
  }

  Widget cardItem(
      {required BuildContext context,
      required iconName,
      required String title,
      required String summery,
      required String startDate,
      required String endDate}) {
    return Container(
      height: 280,
      width: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            // blurRadius: 100,
            spreadRadius: 0.5,
            offset: Offset(1.5, 1.5),
          )
        ],
        border: Border.all(
          color: Theme.of(context).indicatorColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Row(
                children: [
                  Icon(
                    iconName,
                    color: Theme.of(context).indicatorColor,
                    // size: 27,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonText(
                    text: title,
                    style: FontStyles.heading6,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CommonText(
              text: summery,
              style: FontStyles.body,
            ),
            const SizedBox(
              height: 20,
            ),
            // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonText(
                    text: startDate,
                    style: FontStyles.body,
                    color: Theme.of(context).indicatorColor,
                  ),
                  CommonText(
                    text: " $endDate",
                    style: FontStyles.body,
                    color: Theme.of(context).indicatorColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
