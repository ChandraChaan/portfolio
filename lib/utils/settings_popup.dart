import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import '../providers/user_info.dart';
import '../ui/responsive_ui.dart';

class LunchSettings extends StatelessWidget {
  const LunchSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const SettingsPopup();
                });
          },
          child: Icon(Icons.settings, color: Theme.of(context).primaryColor,)),
    );
  }
}

class SettingsPopup extends StatefulWidget {
  const SettingsPopup({super.key});

  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ThemeSection(),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                      DataControlSection(),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                      GeneralSettingsSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      tablet: Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    // Left Side - Sections
                    SizedBox(
                      width: 200.0, // Adjust the width as needed
                      child: ListView(
                        children: [
                          SectionItem(
                            title: 'Theme',
                            icon: Icons.color_lens,
                            index: 0,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                          ),
                          SectionItem(
                            title: 'Data Control',
                            icon: Icons.data_usage,
                            index: 1,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                          ),
                          SectionItem(
                            title: 'General Settings',
                            icon: Icons.settings,
                            index: 2,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Right Side - Content
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
                          ThemeSection(),
                          DataControlSection(),
                          GeneralSettingsSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      desktop: Dialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width / 1.7,
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    // Left Side - Sections
                    SizedBox(
                      width: 200.0, // Adjust the width as needed
                      child: ListView(
                        children: [
                          SectionItem(
                            title: 'Theme',
                            icon: Icons.color_lens,
                            index: 0,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                          ),
                          SectionItem(
                            title: 'Data Control',
                            icon: Icons.data_usage,
                            index: 1,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                          ),
                          SectionItem(
                            title: 'General Settings',
                            icon: Icons.settings,
                            index: 2,
                            selectedIndex: _selectedIndex,
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Right Side - Content
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
                          ThemeSection(),
                          DataControlSection(),
                          GeneralSettingsSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  SectionItem({
    required this.title,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    final textColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).indicatorColor;

    return ListTile(
      leading: Icon(
        icon,
        color: textColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: onTap,
      tileColor: isSelected ? backgroundColor.withOpacity(0.2) : null,
    );
  }
}

class ThemeSection extends StatelessWidget {
  List<Color> currentColors = [
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.red,
    Colors.deepOrangeAccent,
    Colors.amberAccent,
    Colors.yellowAccent,
    Colors.limeAccent,
    Colors.greenAccent,
    Colors.tealAccent,
    Colors.cyanAccent,
    Colors.lightBlueAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.brown,
  ];

  ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Select theme color',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (int a = 0; a < currentColors.length; a++)
                ColorItem(color: currentColors[a]),
            ],
          ),
        ],
      ),
    );
  }
}

class DataControlSection extends StatelessWidget {
  const DataControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Control',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Data control settings',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            DefaultCacheManager().emptyCache();
          },
          child: const Text('Clear Cache'),
        )
        // Add more data control settings here
      ],
    );
  }
}

class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle styl = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General Settings',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 110,
          child: Consumer<UserInfo>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Container(
                    color: Theme.of(context).indicatorColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.themeLightMode
                            ? const Icon(
                                Icons.sunny,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.nightlight,
                                color: Colors.black,
                              ),
                        Transform.scale(
                            scale: 1,
                            child: Switch(
                              onChanged: (bool newVal) {
                                provider.changeThemeMode();
                              },
                              value: provider.themeLightMode,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.white38,
                              inactiveThumbColor: Colors.black,
                              inactiveTrackColor: Colors.black38,
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.musicMode
                          ? const Icon(
                              Icons.add_alert_sharp,
                              color: Colors.lightGreenAccent,
                            )
                          : const Icon(
                              Icons.volume_mute_outlined,
                              color: Colors.redAccent,
                            ),
                      Transform.scale(
                          scale: 1,
                          child: Switch(
                            onChanged: (bool newVal) {
                              provider.changeMusicMode();
                            },
                            value: provider.musicMode,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.greenAccent,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.red,
                          )),
                    ],
                  ),
                  TextButton(
                      onPressed: provider.nLoading == false
                          ? () {
                              // sendNotificationThis();
                            }
                          : null,
                      child: provider.nLoading
                          ? Text(
                              'Loading...',
                              style: styl,
                            )
                          : Text('Notification', style: styl).animate(effects: [
                              const ShakeEffect(
                                  duration: Duration(minutes: 2),
                                  delay: Duration(seconds: 5))
                            ])),
                ],
              );
            },
          ),
        ),
        // Add more general settings here
      ],
    );
  }
}

class ColorItem extends StatelessWidget {
  final Color color;

  ColorItem({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Provider.of<UserInfo>(context, listen: false)
                .themeColorChange(color);
          },
          borderRadius: BorderRadius.circular(25.0),
          splashColor: Colors.white.withOpacity(0.5),
          customBorder: const CircleBorder(),
          child:
              Provider.of<UserInfo>(context, listen: false).themeColor == color
                  ? const Icon(Icons.check)
                  : null,
        ),
      ),
    );
  }
}
