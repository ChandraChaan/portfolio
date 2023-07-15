import 'package:flutter/material.dart';
import 'package:portfoli_web/chat_game/text_animation.dart';
import 'package:portfoli_web/chat_game/youtube_play.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import '../utils/dynamic_image.dart';
import '../utils/font_style.dart';
import 'package:flutter/services.dart';

import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';


class ChatGame extends StatefulWidget {
  final bool hideBackButton;

   ChatGame({super.key, this.hideBackButton = false});

  @override
  State<ChatGame> createState() => _ChatGameState();
}

class _ChatGameState extends State<ChatGame>  with SingleTickerProviderStateMixin{
  FocusNode textFocus = FocusNode();

  bool showChairAnimation = false;

  double chairSize = 0.0;

  late AnimationController _chairController;

  @override
  void initState() {
    super.initState();
    _chairController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _chairController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
        builder: (context, provider, child) {
          provider.ctx = context;
        provider.chatInit();
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(190.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 18.0),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: widget.hideBackButton
                          ? () {
                        if (!showChairAnimation) {
                          setState(() {
                            showChairAnimation = true;
                          });
                          _chairController.forward().then((_) {
                            _chairController.reverse().then((_) {
                              setState(() {
                                showChairAnimation = false;
                              });
                              Navigator.pop(context);
                            });
                          });
                        }
                      }
                          : () {
                        Navigator.pop(context);
                      },

                    icon: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      transform: Matrix4.translationValues(showChairAnimation ? 300.0 :0.0, showChairAnimation ? 300.0 : 0.0, showChairAnimation ? 300.0 :0.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutBack,
                        width: chairSize,
                        height: chairSize,
                        child: Icon(
                          Icons.chair,
                          color: Theme.of(context).primaryColor,
                          size: 35.0,
                        ),
                        onEnd: () {
                          if (showChairAnimation) {
                            setState(() {
                              chairSize = 160.0;
                            });
                          }
                        },
                      ),
                    ),

                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        const CommonText(text:
                          'Welcome to Chat Mini Game',
                          style: FontStyles.heading5,
                        ),
                        const SizedBox(height: 10.0),
                        SelectableText(
                              '${(provider.systemName.isNotEmpty) ? 'System name: ${provider.systemName}' : ''}\n${(provider.browserName.isNotEmpty) ? 'Browser name: ${provider.browserName}' : ''}',
                              style: FontStyles.body.copyWith(color: Theme.of(context).primaryColor),
                            ),
                        Expanded(
                          child: SelectableText(
                            (provider.address.isNotEmpty)
                                ? 'Address: ${provider.address}'
                                : '',
                            style: FontStyles.body.copyWith(color: Theme.of(context).primaryColor, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  if (provider.chargingStatus != 'Unknown')
                    Row(
                      children: [
                         Icon(
                          Icons.battery_full,
                          color: Theme.of(context).focusColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(text:
                          '${provider.chargingStatus}%',
                        ),
                      ],
                    ),
                  const SizedBox(width: 18.0),
                  if (provider.wifiNetworkTypeLoc != 'Unknown')
                    Row(
                      children: [
                         Icon(
                          Icons.wifi,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(text:
                          provider.wifiNetworkTypeLoc,
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
                        controller: provider.chatScrollController,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        itemCount: provider.listMesseges.length,
                        itemBuilder: (context, index) {
                          final message = provider.listMesseges[index];
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
                                      ? Theme.of(context).focusColor.withOpacity(0.5)
                                      : Theme.of(context).indicatorColor.withOpacity(0.5),
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
                                            style: FontStyles.body.copyWith(color: Theme.of(context).primaryColor),
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
                                Center(
                                  child: YouTubePlayerWidget(
                                    videoId: message.song,
                                  ),
                                )
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    if (provider.chatInputController.text.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.filteredSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                                selected: provider.selectedIndex == index ? true:false,
                                title: CommonText(text:provider.filteredSuggestions[index]),
                                onTap: () {
                                  provider.chatInputController.text = provider.filteredSuggestions[index];
                                },
                              );
                        },
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
                            child:  CallbackShortcuts(
                              bindings: <ShortcutActivator, VoidCallback>{
                                const SingleActivator(LogicalKeyboardKey.arrowUp):
                                    () {
                                  if(provider.filteredSuggestions.length > provider.selectedIndex) {
                                    provider.selectedIndex++;
                                    provider.chatInputController.text = provider.filteredSuggestions[provider.selectedIndex];
                                  }
                                },
                                const SingleActivator(LogicalKeyboardKey.arrowDown):
                                    () {
                                  if(provider.filteredSuggestions.length > provider.selectedIndex) {
                                    provider.selectedIndex--;
                                    provider.chatInputController.text = provider.filteredSuggestions[provider.selectedIndex];
                                  }

                                },
                              },
                              child: Focus(
                                autofocus: true,
                                child:TextField(
                                  // autofocus: true,
                                  controller: provider.chatInputController,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: provider.chatGetReply,
                                  style: FontStyles.body.copyWith(color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    hintStyle: FontStyles.body.copyWith(color: Theme.of(context).primaryColor),
                                    hintText: 'Type a message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: provider.chatGetReply,
                            icon: const Icon(Icons.send_sharp),
                            color: Theme.of(context).indicatorColor
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.showTable)
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int a = 1; a < 11; a++)
                        CommonText(text:
                          '${provider.userText} x $a = ${(a * provider.rNumber).toString()}',

                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }
    );
  }
}


