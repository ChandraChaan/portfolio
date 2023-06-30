import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
class YouTubePlayerWidget extends StatefulWidget {
  final String videoId;

  const YouTubePlayerWidget({Key? key, required this.videoId})
      : super(key: key);

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  bool isPlaying = true;
  bool isMuted = false;
  double videoProgress = 0.0;

  YoutubePlayerController _youtubeController =
  YoutubePlayerController.fromVideoId(
    videoId: '',
    autoPlay: false,
    params: const YoutubePlayerParams(
        mute: true,
        enableCaption: false,
        pointerEvents: PointerEvents.none,
        showControls: false,
        enableKeyboard: false,
        enableJavaScript: false,
        showFullscreenButton: false,
        showVideoAnnotations: false),
  );

  @override
  void initState() {
    _youtubeController = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: isPlaying,
      params: YoutubePlayerParams(
          mute: isMuted,
          enableCaption: false,
          pointerEvents: PointerEvents.none,
          showControls: false,
          enableKeyboard: false,
          enableJavaScript: false,
          showFullscreenButton: false,
          showVideoAnnotations: false),
    )..listen((event) {
      videoProgressListener(event);
    });
    super.initState();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _youtubeController.playVideo();
      } else {
        _youtubeController.pauseVideo();
      }
    });
  }

  void toggleMuteUnmute() {
    setState(() {
      isMuted = !isMuted;
      if (isMuted) {
        _youtubeController.mute();
      } else {
        _youtubeController.unMute();
      }
    });
  }

  videoProgressListener(YoutubePlayerValue? value) {
    double progress = double.parse(_youtubeController.currentTime.toString()) /
        _youtubeController.value.metaData.duration.inSeconds;
    setState(() {
      videoProgress = progress;
    });
  }

  void seekTo(double value) {
    setState(() {
      videoProgress = value;
      double seekToDuration = double.parse(
          (_youtubeController.value.metaData.duration.inSeconds * videoProgress)
              .round()
              .toString());
      print(seekToDuration);
      _youtubeController.seekTo(seconds: seekToDuration, allowSeekAhead: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          ),
        ],
      ),
      height: 350,
      width: 400,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: YoutubePlayer(
              controller: _youtubeController,
              aspectRatio: 16 / 9,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          color: Colors.white,
                          onPressed: togglePlayPause,
                        ),
                        IconButton(
                          icon: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          color: Colors.white,
                          onPressed: toggleMuteUnmute,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Slider(
                      value: videoProgress,
                      onChanged: seekTo,
                      activeColor: Colors.red,
                      inactiveColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}