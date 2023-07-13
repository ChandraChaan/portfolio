import 'package:flutter/material.dart';
import 'package:portfoli_web/core/common/scroll.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info.dart';
import '../../utils/font_style.dart';
import '../../utils/settings_popup.dart';

Drawer drawerMobile(BuildContext context) {
  return const Drawer(
    child: SideBarUI(),
  );
}
class SideBarUI extends StatelessWidget {
  const SideBarUI({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return Container(
          color: Theme.of(context).indicatorColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LunchSettings(),
              const SizedBox(height: 50),
              Container(
                height: 160,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/profile.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.menuList.length,
                  itemBuilder: (context, index) {
                    final menuItem = provider.menuList[index];
                    final bool isVisible = menuItem['visibility'] == true;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextButton(
                        onPressed: () {
                          scrollSmooth(
                            provider.scrollKeyValue(index).currentContext!,
                          );
                          provider.updateVisibility(index);
                        },
                        child: CommonText(
                          text: menuItem['name'].toString().toUpperCase(),
                          color: isVisible ? Theme.of(context).focusColor : null,
                          style: isVisible ? FontStyles.heading6 : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
