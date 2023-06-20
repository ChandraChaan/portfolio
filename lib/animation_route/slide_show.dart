import 'package:flutter/material.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';

class SlideShowImage extends StatefulWidget {
  const SlideShowImage({super.key});

  @override
  _SlideShowImageState createState() => _SlideShowImageState();
}

class _SlideShowImageState extends State<SlideShowImage> {
  final List<String> topImages = [
    'mohan_paru/IMG_1196.JPG',
    'mohan_paru/IMG_1197.JPG',
    'mohan_paru/IMG_1198.JPG',
    'mohan_paru/IMG_1199.JPG',
    'mohan_paru/IMG_1200.JPG',
    'mohan_paru/IMG_1207.JPG',
    'mohan_paru/IMG_1209.JPG',
    for (int a = 10; a <= 30; a++) 'mohan_paru/IMG_12$a.JPG',
    for (int a = 32; a <= 47; a++) 'mohan_paru/IMG_12$a.JPG',
  ];

  late List<String> bottomImages;

  late PageController _topPageController;
  late PageController _bottomPageController;
  int _topCurrentPage = 0;
  int _bottomCurrentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _topPageController = PageController(initialPage: _topCurrentPage);
    _bottomPageController = PageController(initialPage: _bottomCurrentPage);
    bottomImages = topImages.reversed.toList();
    // Auto-scrolling timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_topCurrentPage < topImages.length - 1) {
        _topCurrentPage++;
      } else {
        _topCurrentPage = 0;
      }

      if (_bottomCurrentPage > 0) {
        _bottomCurrentPage--;
      } else {
        _bottomCurrentPage = bottomImages.length - 1;
      }

      _topPageController.animateToPage(
        _topCurrentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      _bottomPageController.animateToPage(
        _bottomCurrentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _topPageController.dispose();
    _bottomPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                itemCount: topImages.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.asset(
                          topImages[itemIndex],
                          fit: BoxFit.cover,
                        ),
                options: CarouselOptions(
                  viewportFraction: 0.3,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black,
                ),
                child: const VideoPlayerWidget(url: 'mohan_paru/IMG_1231.MOV',),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: CarouselSlider.builder(
                itemCount: bottomImages.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.asset(
                          bottomImages[itemIndex],
                          fit: BoxFit.cover,
                        ),
                options: CarouselOptions(
                  viewportFraction: 0.3,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset(widget.url)
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
              _videoPlayerController.play();
              _videoPlayerController.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVideoInitialized) {
      return const CircularProgressIndicator();
    }

    return AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: VideoPlayer(_videoPlayerController),
    );
  }
}

class ConfettiScreenPage extends StatefulWidget {
  final Widget childWidget;

  const ConfettiScreenPage({required this.childWidget});

  @override
  _ConfettiScreenPageState createState() => _ConfettiScreenPageState();
}

class _ConfettiScreenPageState extends State<ConfettiScreenPage> {
  late ConfettiController controllerTopCenter;

  @override
  void initState() {
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 180));
  }

  @override
  Widget build(BuildContext context) {
    controllerTopCenter.play();
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onDoubleTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(child: VideoPlayerWidget(url: 'mohan_paru/IMG_1793.MOV',),)),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Stack(
            children: <Widget>[
              widget.childWidget,
              buildLConfettiWidget(controllerTopCenter),
              buildRConfettiWidget(controllerTopCenter),
            ],
          ),
        ),
      ),
    );
  }

  Align buildLConfettiWidget(controller) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConfettiWidget(
          shouldLoop: true,
          confettiController: controller,
          blastDirection: pi / 45,
          numberOfParticles: 99,
          blastDirectionality: BlastDirectionality.explosive),
    );
  }

  Align buildRConfettiWidget(controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConfettiWidget(
          shouldLoop: true,
          confettiController: controller,
          numberOfParticles: 99,
          blastDirection: pi / 45,
          blastDirectionality: BlastDirectionality.explosive),
    );
  }
}
