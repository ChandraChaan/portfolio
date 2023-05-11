import 'package:flutter/cupertino.dart';

import 'gaming_page.dart';

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute() : super(builder: (BuildContext context) => WhatsAppChatUI());

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
            child: WhatsAppChatUI(),
          ),
        ));
  }
}
