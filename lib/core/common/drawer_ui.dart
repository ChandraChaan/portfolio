import 'package:flutter/material.dart';
import 'package:portfoli_web/core/common/scroll.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info.dart';
import '../../utils/font_style.dart';
import '../../utils/settings_popup.dart';

Drawer drawerMobile(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Consumer<UserInfo>(builder: (context, provider, child) {
        return Container(
          color: Theme.of(context).indicatorColor,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LunchSettings(),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 160,
                width: 140,
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Center(
                  child: Container(
                      height: 150,
                      width: 130,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                            image: AssetImage("assets/profile.jpg"),
                            fit: BoxFit.fill,
                          ))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (int a = 0; a < provider.menuList.length; a++) ...[
                TextButton(
                  onPressed: () {
                    scrollSmooth(provider.scrollKeyValue(a).currentContext!);
                  },
                  child: CommonText(
                      text: '${provider.menuList[a]['name']}'.toUpperCase(),
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
        );
      }),
    ),
  );
}
