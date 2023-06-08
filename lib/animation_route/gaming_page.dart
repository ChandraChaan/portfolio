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

  _getReply() async {
    final String userGivenText = inputController.text.trim();

    if (userGivenText.isNotEmpty) {
      _userText = userGivenText;
      String userText = userGivenText.toLowerCase();
      inputController.clear();
      addItemToList(Messages(msg: _userText, left: false, shape: 'null'));

      String? rText;
      if (userGivenText.isNumeric) {
        rNumber = int.parse(userGivenText);
        rText = (2 * rNumber).toString();
        showTable = true;
        container = false;
        circle = false;
      } else {
        showTable = false;
        List<String> name = userGivenText.split(' ');
        if (name[0] == 'create') {
          if (name.contains('container')) {
            container = true;
            circle = false;
            rText = 'Container';
          } else if (name.contains('circle')) {
            container = false;
            circle = true;
            rText = 'Circle';
          } else {
            container = false;
            circle = false;
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
        } else {
          container = false;
          circle = false;
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
          Messages(msg: rText ?? "I didn't get", left: true, shape: shape));
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
        preferredSize: const Size.fromHeight(130.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  children: [
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
                    const SizedBox(
                      width: 18.0,
                    ),
                    const SelectableText('Welcome to Time Pass Game \n'),
                    SelectableText(
                        '${(provd.systemName.isNotEmpty) ? '\nSystem name: ${provd.systemName}' : ''} ${(provd.browserName.isNotEmpty) ? '\nBrowser name: ${provd.browserName}' : ''}'),
                    const SizedBox(
                      width: 18.0,
                    ),
                    if (provd.chargingStatus != 'Unknown')
                      Row(
                        children: [
                          const Icon(
                            Icons.battery_full,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 5),
                          Text('${provd.chargingStatus}%'),
                        ],
                      ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    if (provd.wifiNetworkTypeLoc != 'Unknown')
                      Row(
                        children: [
                          const Icon(
                            Icons.wifi,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 5),
                          Text(provd.wifiNetworkTypeLoc),
                        ],
                      )
                  ],
                ),
              ),
              SelectableText(
                (provd.address.isNotEmpty) ? '\nAddress: ${provd.address}' : '',
                style: const TextStyle(overflow: TextOverflow.ellipsis),
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

  Messages({required this.msg, required this.left, required this.shape});
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
