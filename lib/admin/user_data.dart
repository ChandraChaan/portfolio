import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../chat_game/message_domain.dart';
import '../chat_game/text_animation.dart';
import '../chat_game/youtube_play.dart';
import '../providers/user_info.dart';
import '../utils/font_style.dart';

class UserDataScreen extends StatelessWidget {
  final String systemName;
  final String browserName;
  final String docId;
  final String deviceType;
  final String deviceRam;
  final String tokenFcm;
  final String address;
  final String battery;
  final String wifi;
  final String sound;
  final String darkTheme;
  final String colorTheme;
  final String seenChatScreen;
  final String seenFullResume;
  final String seenAdminScreen;
  final String date;
  final Function()? onPre;

  const UserDataScreen({
    super.key,
    required this.systemName,
    required this.browserName,
    required this.docId,
    required this.deviceRam,
    required this.deviceType,
    required this.tokenFcm,
    required this.address,
    required this.battery,
    required this.wifi,
    required this.sound,
    required this.darkTheme,
    required this.colorTheme,
    required this.seenChatScreen,
    required this.seenFullResume,
    required this.seenAdminScreen,
    required this.date,
    required this.onPre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: darkTheme.toString() == 'true' ? Colors.black26 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if (seenChatScreen != '0')
              Colors.blue.shade600
            else
              Colors.grey.shade400,
            if (seenAdminScreen != '0')
              Colors.deepPurple.shade600
            else
              Colors.grey.shade400,
            if (seenFullResume != '0')
              Colors.amber.shade600
            else
              Colors.grey.shade400,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip(label: systemName, icon: deviceIcon()),
            _buildChip(label: deviceRam, icon: Icons.memory),
            _buildChip(label: browserName, icon: Icons.web),
            _buildChip(label: address, icon: Icons.location_pin),
            _buildChip(label: null, icon: Icons.battery_full),
            _buildChip(
                label: null,
                icon: wifi == 'Connected' ? Icons.wifi : Icons.wifi_off),
            _buildChip(
                label: null,
                icon: sound.toString() != 'false'
                    ? Icons.volume_up
                    : Icons.volume_off),
            _buildChip(
                label: null,
                icon: darkTheme.toString() == 'true'
                    ? Icons.brightness_2
                    : Icons.sunny),
            _buildChip(label: date, icon: Icons.calendar_today),
            if (tokenFcm.toString().isNotEmpty &&
                tokenFcm.toString() != 'null' &&
                tokenFcm.toString() != 'no')
              ElevatedButton(
                onPressed: onPre,
                child: const Text('Send Message'),
              ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChatPopup(conversationId: docId);
                  },
                );
              },
              child: const Text('View Chat'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({String? label, required IconData icon}) {
    return Material(
      elevation: 4.0, // Adjust the elevation to control the shadow intensity
      borderRadius: BorderRadius.circular(16.0),
      shadowColor: Colors.grey[400], // Customize the shadow color
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: darkTheme.toString() == 'true' ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: (colorTheme.toString() != 'null' &&
                      colorTheme.toString().isNotEmpty)
                  ? Color(int.parse(colorTheme))
                  : (darkTheme.toString() == 'true'
                      ? Colors.white
                      : Colors.black),
            ),
            if (label != null) ...[
              const SizedBox(width: 8.0),
              Text(
                label ?? '',
                maxLines: 4,
                style: TextStyle(
                  color: darkTheme.toString() == 'true'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData deviceIcon() {
    if (deviceType == 'Mobile') {
      return Icons.phone_android;
    } else if (deviceType == 'Tablet') {
      return Icons.tab;
    } else if (deviceType == 'Desktop') {
      return Icons.desktop_mac;
    } else {
      return Icons.mobile_off;
    }
  }
}

class ChatPopup extends StatefulWidget {
  final String conversationId;

  ChatPopup({required this.conversationId});

  @override
  State<ChatPopup> createState() => _ChatPopupState();
}

class _ChatPopupState extends State<ChatPopup> {
  final ScrollController popupScrollController =
      ScrollController(initialScrollOffset: 2.0);
  TextEditingController popupTextController = TextEditingController();

  void addItemToList(Messages message, BuildContext context) {
    Provider.of<UserInfo>(context, listen: false).addMessageToConversation(
        widget.conversationId, message.sender, message.msg);
    // Delay the scroll animation slightly
    Future.delayed(const Duration(milliseconds: 100), () {
      popupScrollController.animateTo(
        popupScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    popupTextController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserInfo>(context, listen: false);
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chat Messages',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('conversations')
                    .doc(widget.conversationId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final documents = snapshot.data!.docs;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: popupScrollController,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final message = documents[index];
                            return Column(
                              crossAxisAlignment: message['left'] == false
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: message['left'] == true
                                        ? Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5)
                                        : Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return message['left'] == false
                                          ? SelectableText(
                                              message['msg'],
                                              style: FontStyles.body.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            )
                                          : SelectableText(
                                              message['msg'],
                                              style: FontStyles.body.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            );
                                    },
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
                              child: Focus(
                                autofocus: true,
                                child: TextField(
                                  controller: popupTextController,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: provider.chatGetReply,
                                  style: FontStyles.body.copyWith(
                                      color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    hintStyle: FontStyles.body.copyWith(
                                        color: Theme.of(context).primaryColor),
                                    hintText: 'Type a message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                addItemToList(
                                    Messages(
                                        msg: popupTextController.text,
                                        left: false,
                                        shape: '',
                                        song: '',
                                        sender: 'admin',
                                        images: []
                                    ),
                                    context);
                              },
                              icon: const Icon(Icons.send_sharp),
                              color: Theme.of(context).indicatorColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
