import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Column(children: [
          const SizedBox(
            height: 50,
          ),
          getTextStyle("EXPERIENCE", FontWeight.bold, Colors.black, 50),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 6,
            width: 120,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: provider.expData.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  childAspectRatio: 2,
                  mainAxisSpacing: 18.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 243,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        // blurRadius: 100,
                        spreadRadius: 0.5,
                        offset: Offset(1.5, 1.5),
                      )
                    ],
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                provider.expData[index]["icon"],
                                color: Colors.blueAccent,
                                size: 27,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              getTextStyle(
                                  "${provider.expData[index]["title"]}",
                                  FontWeight.bold,
                                  Colors.black,
                                  25)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        getTextStyle("${provider.expData[index]["summary"]}",
                            FontWeight.normal, Colors.black45, 17),
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
                                  Colors.blue,
                                  18),
                              getTextStyle(
                                  " - ${provider.expData[index]["present"] != true ? provider.expData[index]["endDate"] : 'Present'}",
                                  FontWeight.normal,
                                  Colors.blue,
                                  18),
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
