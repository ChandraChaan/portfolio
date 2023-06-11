import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:portfoli_web/home_page.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';

// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../utils/dynamic_image.dart';
import '../utils/getReplayList.dart';
import 'navigate_newpage.dart';

class Secondpage extends StatefulWidget {
  final bool hideBackButton;

  Secondpage({Key? key, this.hideBackButton = false}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = TextEditingController();
  String _userText = "Type Something";
  String replyTest = "See The Result";
  bool showTable = false;
  bool container = false;
  bool circle = false;
  int rNumber = 0;
  List<Messages> listMesseges = [];

  _getReply() async {
    final String userGivenText = inputController.text.trim();
    if (userGivenText.isNotEmpty) {
      _userText = userGivenText;
      inputController.clear();
      String userText = userGivenText.toLowerCase();
      List<String> listImages = [];
      String songName = '';
      showTable = false;
      container = false;
      circle = false;
      addItemToList(Messages(
          msg: _userText,
          left: false,
          song: songName,
          shape: 'null',
          images: []));

      String? rText;
      if (userGivenText.isNumeric) {
        rNumber = int.parse(userGivenText);
        rText = (2 * rNumber).toString();
        showTable = true;
      } else {
        List<String> name = userGivenText.split(' ');
        if (name[0] == 'create') {
          if (name.contains('container')) {
            container = true;
            rText = 'Container';
          } else if (name.contains('circle')) {
            circle = true;
            rText = 'Circle';
          } else {
            rText = "I didn't get";
          }
        } else if (name[0] == 'open') {
          if (name.contains('admin')) {
            rText = 'Opening...';
            Navigator.of(context).push(AdminPageRoot());
          } else if (name.contains('resume')) {
            rText = 'Opening...';
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            rText = "I didn't get";
          }
        } else if (name[0] == 'play') {
          int index = name.indexOf('the');
          if (index < name.length - 1) {
            String keyword = name[index + 1];
            rText = 'Here we go...';
            songName = await playVideo(keyword) ?? '';
          } else {
            rText = "I didn't get";
          }
        } else if (name.contains('show') &&
            name.contains('images') &&
            name.contains('of')) {
          // Extract the keyword after 'of'
          int index = name.indexOf('of');
          if (index < name.length - 1) {
            String keyword = name[index + 1];
            rText = 'Here we go...';
            listImages = await fetchGoogleImages(keyword);
          } else {
            rText = "I didn't get";
          }
        }

        List<String> checkKeys = CommonUse().getReplayList.keys.toList();

        await Future.forEach(checkKeys, (key) async {
          if (key.toLowerCase() == userText) {
            rText = CommonUse().getReplayList[key].toString();
          }
        });
        if (rText.toString() == 'null' || rText == "I didn't get") {
          rText = await generateGoogleResponse(_userText);
        }
      }

      String shape = container ? 'container' : (circle ? 'circle' : 'null');
      addItemToList(Messages(
          msg: rText ?? "I didn't get",
          left: true,
          song: songName,
          shape: shape,
          images: listImages));
      setState(() {
        replyTest = rText ?? "I didn't get";
      });
    }
  }

  String apiKey = 'AIzaSyCcyArg2tLT6FgAIvfe_mU2Q1DAzGC1gD4';
  String searchEngineId = '23ca64046b86840ed';
  String yutubeApiKey = 'AIzaSyDNtdImGrUc9SUOCw3Fm8bnbRoa48jfoXg';

  Future<String?> generateGoogleResponse(String query) async {
    final Uri uri = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&q=$query',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('items')) {
        List<dynamic> items = data['items'];
        if (items.isNotEmpty) {
          return items[0]['snippet'];
        }
      }
    }

    return null;
  }

  Future<List<String>> fetchGoogleImages(String keyword) async {
    final Uri uri = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&q=$keyword&searchType=image',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('items')) {
        List<dynamic> items = data['items'];
        if (items.isNotEmpty) {
          return items.map((item) => item['link']).cast<String>().toList();
          // return 'Showing images of $keyword';
        }
      }
    }
    return [];
  }

// API endpoint for downloading a song
  Future<String?> downloadSong(String songName) async {
    try {
      // Search for the song on YouTube
      String searchQuery = Uri.encodeQueryComponent(songName);
      final Uri searchUri = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchQuery&type=video&key=$yutubeApiKey');
      final searchResponse = await http.get(searchUri);

      if (searchResponse.statusCode == 200) {
        Map<String, dynamic> searchData = json.decode(searchResponse.body);
        if (searchData.containsKey('items')) {
          List<dynamic> items = searchData['items'];
          if (items.isNotEmpty) {
            String videoId = items[0]['id']['videoId'];
            String videoUrl = 'https://www.youtube.com/watch?v=$videoId';
            // You can implement your download logic here using the videoUrl
            return videoUrl;
          }
        }
      }
    } catch (e) {
      print('Error downloading song: $e');
    }

    return null;
  }

  Future<void> downloadVideo(String videoUrl) async {
    try {
      // Send an HTTP GET request to download the video file
      final response = await http.get(Uri.parse(videoUrl));

      if (response.statusCode == 200) {
        // Extract the filename from the URL
        String fileName = videoUrl.split('/').last;

        // Specify the path where you want to save the downloaded video file
        String savePath = '/path/to/save/$fileName';

        // Create a new file at the save path
        final File file = File(savePath);

        // Write the response body (video content) to the file
        await file.writeAsBytes(response.bodyBytes);

        print('Video downloaded successfully at: $savePath');
      } else {
        print('Error downloading video: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading video: $e');
    }
  }

// API endpoint for playing a song
  Future<String?> playSong(String songName) async {
    try {
      // Search for the song on YouTube
      String searchQuery = Uri.encodeQueryComponent(songName);
      final Uri searchUri = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchQuery&type=video&key=$yutubeApiKey');
      final searchResponse = await http.get(searchUri);

      if (searchResponse.statusCode == 200) {
        Map<String, dynamic> searchData = json.decode(searchResponse.body);
        if (searchData.containsKey('items')) {
          List<dynamic> items = searchData['items'];
          if (items.isNotEmpty) {
            String videoId = items[0]['id']['videoId'];
            String videoUrl = 'https://www.youtube.com/watch?v=$videoId';
            // You can implement your song playback logic here using the videoUrl
            return videoUrl;
          }
        }
      }
    } catch (e) {
      print('Error playing song: $e');
    }

    return null;
  }

// API endpoint for playing a video
  Future<String?> playVideo(String videoName) async {
    try {
      // Search for the video on YouTube
      String searchQuery = Uri.encodeQueryComponent(videoName);
      final Uri searchUri = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchQuery&type=video&key=$yutubeApiKey');
      final searchResponse = await http.get(searchUri);

      if (searchResponse.statusCode == 200) {
        Map<String, dynamic> searchData = json.decode(searchResponse.body);
        if (searchData.containsKey('items')) {
          List<dynamic> items = searchData['items'];
          if (items.isNotEmpty) {
            String videoId = items[0]['id']['videoId'];
            print(videoId);
            String videoUrl = 'https://www.youtube.com/watch?v=$videoId';
            // You can implement your video playback logic here using the videoUrl
            return videoId;
          }
        }
      }
    } catch (e) {
      print('Error playing video: $e');
    }

    return null;
  }

  ScrollController _scrollController = ScrollController();

  void addItemToList(Messages message) {
    setState(() {
      listMesseges.add(message);
    });

    // Delay the scroll animation slightly
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provd = Provider.of<UserInfo>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 18.0),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: widget.hideBackButton
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                icon: Icon(
                  widget.hideBackButton ? Icons.chair : Icons.arrow_back,
                  color: Colors.black,
                  size: 35.0,
                ),
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text(
                      'Welcome to Time Pass Game',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Consumer<UserInfo>(
                      builder: (context, person, child) {
                        return SelectableText(
                          '${(person.systemName.isNotEmpty) ? 'System name: ${person.systemName}' : ''}\n${(person.browserName.isNotEmpty) ? 'Browser name: ${person.browserName}' : ''}',
                          style: TextStyle(fontSize: 16.0),
                        );
                      },
                    ),
                    SelectableText(
                      (provd.address.isNotEmpty)
                          ? 'Address: ${provd.address}'
                          : '',
                      style: const TextStyle(
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              const SizedBox(width: 18.0),
              if (context.read<UserInfo>().chargingStatus != 'Unknown')
                Row(
                  children: [
                    const Icon(
                      Icons.battery_full,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${context.read<UserInfo>().chargingStatus}%',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              const SizedBox(width: 18.0),
              if (context.read<UserInfo>().wifiNetworkTypeLoc != 'Unknown')
                Row(
                  children: [
                    const Icon(
                      Icons.wifi,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      context.read<UserInfo>().wifiNetworkTypeLoc,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemCount: listMesseges.length,
                    itemBuilder: (context, index) {
                      final message = listMesseges[index];
                      return Column(
                        crossAxisAlignment: message.left
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: message.left
                                  ? Colors.grey[300]
                                  : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return message.left
                                    ? TypewriterTextAnimation(
                                        text: message.msg,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        constraints: constraints,
                                      )
                                    : SelectableText(
                                        message.msg,
                                        style: const TextStyle(fontSize: 16),
                                      );
                              },
                            ),
                          ),
                          if (message.shape != 'null')
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: message.shape == 'circle'
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: message.shape == 'container'
                                    ? BorderRadius.circular(12)
                                    : null,
                              ),
                              height: 150,
                              width: 150,
                            ),
                          if (message.images.isNotEmpty && message.left)
                            Wrap(
                              children: [
                                for (int a = 0; a < message.images.length; a++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 150,
                                    width: 150,
                                    child: ImageDynamic(img: message.images[a]),
                                  )
                              ],
                            ),
                          if ((message.song.toString() != 'null' &&
                                  message.song.isNotEmpty) &&
                              message.left)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 250,
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: YouTubePlayerWidget(
                                  videoId: message.song,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: inputController,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _getReply,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _getReply,
                        icon: const Icon(Icons.send_sharp),
                        color:
                            Colors.blue, // Set your desired send button color
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showTable)
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int a = 1; a < 11; a++)
                    Text(
                      '$_userText x $a = ${(a * rNumber).toString()}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}

class Messages {
  final String msg;
  final bool left;
  final String shape;
  final List<String> images;
  final String song;

  Messages(
      {required this.msg,
      required this.left,
      required this.shape,
      required this.song,
      required this.images});
}

class TypewriterTextAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final BoxConstraints? constraints;

  TypewriterTextAnimation({
    required this.text,
    required this.duration,
    this.constraints,
  });

  @override
  _TypewriterTextAnimationState createState() =>
      _TypewriterTextAnimationState();
}

class _TypewriterTextAnimationState extends State<TypewriterTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _textAnimation = IntTween(begin: 0, end: widget.text.length)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        final animatedText = widget.text.substring(0, _textAnimation.value);
        return Container(
          constraints: widget.constraints,
          child: Text(animatedText, style: const TextStyle(fontSize: 18)),
        );
      },
    );
  }
}

class YouTubePlayerWidget extends StatelessWidget {
  final String videoId;

  const YouTubePlayerWidget({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      showVideoProgressIndicator: true,
      controller: YoutubePlayerController(initialVideoId: videoId),
      aspectRatio: 16 / 9,
    );
  }
}
