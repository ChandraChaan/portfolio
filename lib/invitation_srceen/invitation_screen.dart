import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen({super.key});

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isWidgetVisible = true;
  double _widgetOpacity = 1.0;
  bool alignRight = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        // Adjust the offset value as needed
        setState(() {
          _isWidgetVisible = false;
        });
      } else {
        setState(() {
          _isWidgetVisible = true;
        });
      }

      setState(() {
        _widgetOpacity = 1.0 - (_scrollController.offset / 200.0);
        // 200.0 is the threshold where the widget will become completely transparent
        _widgetOpacity = _widgetOpacity.clamp(0.0, 1.0);
        if (_widgetOpacity < 0.4) {
          alignRight = false;
        }
        else {
          alignRight = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // Update the scrollController
          if (scrollNotification is ScrollUpdateNotification) {
            _scrollController.jumpTo(scrollNotification.metrics.pixels);
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/swetha.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFFFD700).withOpacity(_widgetOpacity),
                        const Color(0xFFFFB90F).withOpacity(_widgetOpacity),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: alignRight
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' ',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              ' ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            AnimatedAlign(
                              alignment: alignRight
                                  ? Alignment.center
                                  : Alignment.bottomRight,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: Text(
                                _isWidgetVisible ? ' ' : 'Swetha',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chandra ObulaReddy',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8.0),
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        WavyAnimatedText('Weds'),
                                        WavyAnimatedText('Weds'),
                                        WavyAnimatedText('Weds'),
                                      ],
                                      isRepeatingAnimation: true,
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Opacity(
                                    opacity: _isWidgetVisible
                                        ? 1
                                        : (_widgetOpacity / 8),
                                    child: Text(
                                      _isWidgetVisible ? 'Swetha' : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 32.0),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: _isWidgetVisible
                                  ? FadeTransition(
                                opacity: _animation,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    size: 60.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                              child: FadeTransition(
                                opacity: _animation,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    size: 60.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/chandra.JPG'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
