import 'package:flutter/material.dart';
import 'package:portfoli_web/home_page.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'dart:async';

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
  // List<String> listImages = [];

  _getReply() async {
    final String userGivenText = inputController.text.trim();
    if (userGivenText.isNotEmpty) {
      _userText = userGivenText;
      inputController.clear();
      String userText = userGivenText.toLowerCase();
      List<String> listImages = [];
      showTable = false;
      container = false;
      circle = false;
      addItemToList(Messages(msg: _userText, left: false, shape: 'null', images: []));

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
        }
        else if (name[0] == 'open') {
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
        }
        else if(name[0] == 'show'){

          //TODO : API call for google images
          rText = 'Here we go...';
          listImages = ['https://akm-img-a-in.tosshub.com/indiatoday/images/story/202205/Jr-NTR-n-1200by667_1200x768.jpeg?VersionId=u5nt3.z6xrqfONmd_vPjNTKjTPEfTYDg&size=690:388', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/44686/activa-6g-right-front-three-quarter.jpeg?q=80'];
        }


        List<String> checkKeys = CommonUse().getReplayList.keys.toList();

        await Future.forEach(checkKeys, (key) async {
          if (key.toLowerCase() == userText) {
            rText = CommonUse().getReplayList[key].toString();
          }
        });
      }

      String shape = container ? 'container' : (circle ? 'circle' : 'null');
      addItemToList(
          Messages(msg: rText ?? "I didn't get", left: true, shape: shape, images: listImages));
      setState(() {
        replyTest = rText ?? "I didn't get";
      });
    }
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
                onPressed: widget.hideBackButton ? null : () {
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
                      (provd.address.isNotEmpty) ? 'Address: ${provd.address}' : '',
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
                                    : Text(
                                        message.msg,
                                        style: const TextStyle(fontSize: 16),
                                        maxLines: null,
                                        overflow: TextOverflow.clip,
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
                                for(int a=0; a<message.images.length; a++)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 150,
                                  width: 150,
                                  child: Image.network(message.images[a]),
                                )
                              ],
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

  Messages({required this.msg, required this.left, required this.shape, required this.images});
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
