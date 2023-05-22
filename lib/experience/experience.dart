import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          const SizedBox(
            height: 50,
          ),
          getTextStyle("EXPERIENCE", FontWeight.bold,
              Theme.of(context).primaryColor, 50),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 6,
            width: 120,
            color: Theme.of(context).indicatorColor,
          ),
          const SizedBox(
            height: 10,
          ),
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
                        child: Container(
                          height: 210,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
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
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        provider.expData[index]["icon"],
                                        color: Theme.of(context).indicatorColor,
                                        size: 27,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextStyle(
                                          "${provider.expData[index]["title"]}",
                                          FontWeight.bold,
                                          Theme.of(context).primaryColor,
                                          25)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                getTextStyle(
                                    "${provider.expData[index]["summary"]}",
                                    FontWeight.normal,
                                    Theme.of(context).primaryColor,
                                    11),
                                const SizedBox(
                                  height: 20,
                                ),
                                // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      getTextStyle(
                                          "${provider.expData[index]["startDate"]}",
                                          FontWeight.normal,
                                          Theme.of(context).indicatorColor,
                                          14),
                                      getTextStyle(
                                          " - ${provider.expData[index]["present"] != true ? provider.expData[index]["endDate"] : 'Present'}",
                                          FontWeight.normal,
                                          Theme.of(context).indicatorColor,
                                          14),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                            childAspectRatio: 2,
                            mainAxisSpacing: 18.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 210,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
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
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      provider.expData[index]["icon"],
                                      color: Theme.of(context).indicatorColor,
                                      size: 27,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    getTextStyle(
                                        "${provider.expData[index]["title"]}",
                                        FontWeight.bold,
                                        Theme.of(context).primaryColor,
                                        25)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              getTextStyle(
                                  "${provider.expData[index]["summary"]}",
                                  FontWeight.normal,
                                  Theme.of(context).primaryColor,
                                  12),
                              const SizedBox(
                                height: 20,
                              ),
                              // getTextStyle("March 2019 - Present", FontWeight.normal, Colors.blue, 18),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    getTextStyle(
                                        "${provider.expData[index]["startDate"]}",
                                        FontWeight.normal,
                                        Theme.of(context).indicatorColor,
                                        14),
                                    getTextStyle(
                                        " - ${provider.expData[index]["present"] != true ? provider.expData[index]["endDate"] : 'Present'}",
                                        FontWeight.normal,
                                        Theme.of(context).indicatorColor,
                                        14),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
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
}
