import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info.dart';

srollSmooth(BuildContext context) {
  if (Provider.of<UserInfo>(context, listen: false).musicMode)
  {
    AudioPlayer().play(AssetSource('audio/decide.mp3'));
  }
  Scrollable.ensureVisible(context,
      duration: const Duration(seconds: 1), curve: Curves.easeIn);
}

final aboutScrollKey = GlobalKey();
bool isAboutVisible = false;
final expScrollKey = GlobalKey();
bool isExpVisible = false;

final portfoScrollKey = GlobalKey();
bool isPortfoVisible = false;

final skillScrollKey = GlobalKey();
bool isSkillsVisible = false;

final projectsScrollKey = GlobalKey();
bool isProjectsVisible = false;

final contactScrollKey = GlobalKey();
bool isContactVisible = false;