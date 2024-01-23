import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/auth_screen.dart';
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
            child:  const ChatGame(),
          ),
        ));
  }
}

class AdminPageRoot extends CupertinoPageRoute {
  AdminPageRoot() : super(builder: (BuildContext context) => const AdminData());

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

class AuthScreenRoute extends PageRouteBuilder {
  AuthScreenRoute() : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return const AuthScreen();
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return Stack(
        children: [
          // Background animation with expanding circles
          AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).indicatorColor.withOpacity(0.8),
                      Theme.of(context).indicatorColor.withOpacity(0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.8, 1.0],
                    radius: animation.value * 8,
                  ),
                ),
              );
            },
          ),
          // Horizontal animated line
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(animation.value * MediaQuery.of(context).size.width, 0),
                  child: Container(
                    height: 2,
                    color: Theme.of(context).focusColor,
                  ),
                );
              },
            ),
          ),
          // Your actual screen content
          FadeTransition(
            opacity: animation,
            child: child,
          ),
        ],
      );
    },
    transitionDuration: const Duration(milliseconds: 2500),
  );
}
