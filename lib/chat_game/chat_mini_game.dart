import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:portfoli_web/chat_game/text_animation.dart';
import 'package:portfoli_web/chat_game/youtube_play.dart';
import 'package:portfoli_web/utils/constants.dart';
import 'package:portfoli_web/utils/slide_show.dart';
import 'package:portfoli_web/core/home_page.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../utils/dynamic_image.dart';
import '../utils/font_style.dart';
import '../utils/getReplayList.dart';
import '../animation_route/navigate_newpage.dart';
import 'package:flutter/services.dart';

import 'message_domain.dart';

class ChatGame extends StatelessWidget {
  final bool hideBackButton;

  ChatGame({super.key, this.hideBackButton = false});

  FocusNode textFocus = FocusNode();

  List<String> suggestions = [
    'show some images of ',
    'Hello',
    'create a container',
    'create a circle',
    'play',
  ];
  List<String> filteredSuggestions = [];
  int selectedIndex = -1;

  // @override
  // void initState() {
  //   super.initState();
  //   selectedIndex = filteredSuggestions.length-1;
  //   inputController.addListener(filterSuggestions);
  // }
  //
  // void filterSuggestions() {
  //   setState(() {
  //     String searchText = inputController.text.toLowerCase();
  //     filteredSuggestions = suggestions
  //         .where((suggestion) => suggestion.toLowerCase().contains(searchText))
  //         .toList();
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   inputController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
        builder: (context, provider, child) {
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
                    onPressed: hideBackButton
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    icon: Icon(
                      hideBackButton ? Icons.chair : Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                      size: 35.0,
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
                        itemCount: filteredSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                                selected: selectedIndex == index ? true:false,
                                title: CommonText(text:filteredSuggestions[index]),
                                onTap: () {
                                  provider.chatInputController.text = filteredSuggestions[index];
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
                                  if(filteredSuggestions.length > selectedIndex) {
                                    selectedIndex++;
                                    provider.chatInputController.text = filteredSuggestions[selectedIndex];
                                  }

                                },
                                const SingleActivator(LogicalKeyboardKey.arrowDown):
                                    () {
                                  if(filteredSuggestions.length > selectedIndex) {
                                    selectedIndex--;
                                    provider.chatInputController.text = filteredSuggestions[selectedIndex];
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


