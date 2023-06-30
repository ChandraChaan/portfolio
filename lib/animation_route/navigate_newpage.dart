import 'package:flutter/cupertino.dart';
import '../chat_game/chat_mini_game.dart';
import '../admin/admin_screen.dart';

class ChatGameRoute extends CupertinoPageRoute {
  ChatGameRoute() : super(builder: (BuildContext context) => const ChatGame());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return RotationTransition(
        turns: animation,
        child: ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: const ChatGame(),
          ),
        ));
  }
}

class AdminPageRoot extends CupertinoPageRoute {
  AdminPageRoot() : super(builder: (BuildContext context) => AdminData());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return RotationTransition(
        turns: animation,
        child: ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: const AdminData(),
          ),
        ));
  }
}
