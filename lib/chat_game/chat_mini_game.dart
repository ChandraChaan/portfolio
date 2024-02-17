import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/chat_game/text_animation.dart';
import 'package:portfoli_web/chat_game/youtube_play.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';
import '../animation_route/navigate_newpage.dart';
import '../core/home_page.dart';
import '../providers/user_repo.dart';
import '../ui/responsive_ui.dart';
import '../utils/dynamic_image.dart';
import '../utils/font_style.dart';
import 'package:flutter/services.dart';

import '../utils/settings_popup.dart';

class ChatGame extends StatefulWidget {
  final bool hideBackButton;

  const ChatGame({Key? key, this.hideBackButton = false}) : super(key: key);

  @override
  State<ChatGame> createState() => _ChatGameState();
}

class _ChatGameState extends State<ChatGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _chairController;
  late Animation<double> _chairIconAnimation;
  bool bigChair = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _chairController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _chairIconAnimation = Tween<double>(
      begin: 35.0,
      end: 134.0,
    ).animate(CurvedAnimation(
      parent: _chairController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _chairController.dispose();
    super.dispose();
  }

  void _toggleChairAnimation() {
    if (_chairController.status == AnimationStatus.completed ||
        _chairController.status == AnimationStatus.forward) {
      _chairController.reverse();
      setState(() {
        bigChair = false;
      });
    } else {
      _chairController.forward();
      setState(() {
        bigChair = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserInfo>(context, listen: false);
    provider.chatInit(context);

    return ResponsiveWidget(
      mobile: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.auto_awesome_mosaic,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CommonText(
                  text: 'Welcome to Chat Mini Game',
                  style: FontStyles.heading5,
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          shadowColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                margin: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    SelectableText(
                      provider.systemName != null
                          ? 'System name: ${provider.systemName}'
                          : '',
                      style: FontStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SelectableText(
                      provider.browserName != null
                          ? 'Browser name: ${provider.browserName}'
                          : '',
                      style: FontStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: SelectableText(
                        provider.address.isNotEmpty
                            ? 'Address: ${provider.address}'
                            : '',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).primaryColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (provider.batteryStatus != 'Unknown')
                    Row(
                      children: [
                        Icon(
                          Icons.battery_full,
                          color: Theme.of(context).focusColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(
                          text: '${provider.batteryStatus}%',
                        ),
                      ],
                    ),
                  if (provider.wifiNetworkStatus != 'Unknown')
                    Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(
                          text: provider.wifiNetworkStatus,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 10.0),
              Divider(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    ListTile(
                      // tileColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      leading: Icon(
                        Icons.person,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Open resume',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ListTile(
                      // tileColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const SettingsPopup();
                            });
                      },
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Settings',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                                vertical: 10,
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: message.left
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
                                  return message.left
                                      ? TypewriterTextAnimation(
                                          text: message.msg,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          constraints: constraints,
                                        )
                                      : SelectableText(
                                          message.msg,
                                          style: FontStyles.body.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        );
                                },
                              ),
                            ),
                            if (message.shape != 'null')
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
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
                                  for (int a = 0;
                                      a < message.images.length;
                                      a++)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 150,
                                      width: 150,
                                      child: ImageDynamic(
                                        img: message.images[a],
                                      ),
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
                          selected:
                              provider.selectedIndex == index ? true : false,
                          title: CommonText(
                              text: provider.filteredSuggestions[index]),
                          onTap: () {
                            provider.chatInputController.text =
                                provider.filteredSuggestions[index];
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
                          child: CallbackShortcuts(
                            bindings: <ShortcutActivator, VoidCallback>{
                              const SingleActivator(LogicalKeyboardKey.arrowUp):
                                  () {
                                if (provider.filteredSuggestions.length >
                                    provider.selectedIndex) {
                                  provider.selectedIndex++;
                                  provider.chatInputController.text =
                                      provider.filteredSuggestions[
                                          provider.selectedIndex];
                                }
                              },
                              const SingleActivator(
                                  LogicalKeyboardKey.arrowDown): () {
                                if (provider.filteredSuggestions.length >
                                    provider.selectedIndex) {
                                  provider.selectedIndex--;
                                  provider.chatInputController.text =
                                      provider.filteredSuggestions[
                                          provider.selectedIndex];
                                }
                              },
                            },
                            child: Focus(
                              autofocus: true,
                              child: TextField(
                                controller: provider.chatInputController,
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
                        ),
                        IconButton(
                          onPressed: provider.chatGetReply,
                          icon: const Icon(Icons.send_sharp),
                          color: Theme.of(context).indicatorColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // if (provider.showTable)
            //   Expanded(
            //     flex: 5,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         for (int a = 1; a < 11; a++)
            //           CommonText(
            //             text:
            //                 '${provider.userText} x $a = ${(a * provider.rNumber).toString()}',
            //           ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
      tablet: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.auto_awesome_mosaic,
              color: Theme.of(context).primaryColor,
            ),
          ), // Replace 'your_icon' with the desired icon
          title: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CommonText(
                text: 'Welcome to Chat Mini Game',
                style: FontStyles.heading5,
              ),
            ),
          ),
        ),
        drawer: Drawer(
          shadowColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                margin: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    SelectableText(
                      provider.systemName != null
                          ? 'System name: ${provider.systemName}'
                          : '',
                      style: FontStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SelectableText(
                      provider.browserName != null
                          ? 'Browser name: ${provider.browserName}'
                          : '',
                      style: FontStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: SelectableText(
                        provider.address.isNotEmpty
                            ? 'Address: ${provider.address}'
                            : '',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).primaryColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (provider.batteryStatus != 'Unknown')
                    Row(
                      children: [
                        Icon(
                          Icons.battery_full,
                          color: Theme.of(context).focusColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(
                          text: '${provider.batteryStatus}%',
                        ),
                      ],
                    ),
                  if (provider.wifiNetworkStatus != 'Unknown')
                    Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 5),
                        CommonText(
                          text: provider.wifiNetworkStatus,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 10.0),
              Divider(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    ListTile(
                      // tileColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      leading: Icon(
                        Icons.person,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Open resume',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ListTile(
                      // tileColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const SettingsPopup();
                            });
                      },
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Settings',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                                vertical: 10,
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: message.left
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
                                  return message.left
                                      ? TypewriterTextAnimation(
                                          text: message.msg,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          constraints: constraints,
                                        )
                                      : SelectableText(
                                          message.msg,
                                          style: FontStyles.body.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        );
                                },
                              ),
                            ),
                            if (message.shape != 'null')
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
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
                                  for (int a = 0;
                                      a < message.images.length;
                                      a++)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 150,
                                      width: 150,
                                      child: ImageDynamic(
                                        img: message.images[a],
                                      ),
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
                          selected:
                              provider.selectedIndex == index ? true : false,
                          title: CommonText(
                              text: provider.filteredSuggestions[index]),
                          onTap: () {
                            provider.chatInputController.text =
                                provider.filteredSuggestions[index];
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
                          child: CallbackShortcuts(
                            bindings: <ShortcutActivator, VoidCallback>{
                              const SingleActivator(LogicalKeyboardKey.arrowUp):
                                  () {
                                if (provider.filteredSuggestions.length >
                                    provider.selectedIndex) {
                                  provider.selectedIndex++;
                                  provider.chatInputController.text =
                                      provider.filteredSuggestions[
                                          provider.selectedIndex];
                                }
                              },
                              const SingleActivator(
                                  LogicalKeyboardKey.arrowDown): () {
                                if (provider.filteredSuggestions.length >
                                    provider.selectedIndex) {
                                  provider.selectedIndex--;
                                  provider.chatInputController.text =
                                      provider.filteredSuggestions[
                                          provider.selectedIndex];
                                }
                              },
                            },
                            child: Focus(
                              autofocus: true,
                              child: TextField(
                                controller: provider.chatInputController,
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
                        ),
                        IconButton(
                          onPressed: provider.chatGetReply,
                          icon: const Icon(Icons.send_sharp),
                          color: Theme.of(context).indicatorColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // if (provider.showTable)
            //   Expanded(
            //     flex: 5,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         for (int a = 1; a < 11; a++)
            //           CommonText(
            //             text:
            //                 '${provider.userText} x $a = ${(a * provider.rNumber).toString()}',
            //           ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
      desktop: Scaffold(
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
                          if (bigChair) {
                            Navigator.of(context).push(AuthScreenRoute());
                          } else {
                            if (!_chairController.isAnimating) {
                              _toggleChairAnimation();
                            }
                          }
                        }
                      : () {
                          Navigator.pop(context);
                        },
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bigChair
                          ? Theme.of(context).indicatorColor.withOpacity(0.4)
                          : null,
                      boxShadow: widget.hideBackButton
                          ? [
                              BoxShadow(
                                color: Theme.of(context).focusColor,
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 0),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _chairIconAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _chairIconAnimation.value / 35.0,
                            child: Icon(
                              widget.hideBackButton
                                  ? Icons.chair
                                  : Icons.arrow_back_rounded,
                              color: Theme.of(context).primaryColor,
                              size: _chairIconAnimation.value,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      const CommonText(
                        text: 'Welcome to Chat Mini Game',
                        style: FontStyles.heading5,
                      ),
                      const SizedBox(height: 10.0),
                      SelectableText(
                        '${provider.systemName != null ? 'System name: ${provider.systemName}' : ''}\n${provider.browserName != null ? 'Browser name: ${provider.browserName}' : ''}',
                        style: FontStyles.body.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        child: SelectableText(
                          provider.address.isNotEmpty
                              ? 'Address: ${provider.address}'
                              : '',
                          style: FontStyles.body.copyWith(
                            color: Theme.of(context).primaryColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const SizedBox(width: 18.0),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    child: CommonText(
                      text: 'Open Portfolio',
                      color: Theme.of(context).focusColor,
                    )),
                const LunchSettings(
                  noALine: true,
                ),
                const SizedBox(width: 18.0),
                if (provider.batteryStatus != 'Unknown')
                  Row(
                    children: [
                      Icon(
                        Icons.battery_full,
                        color: Theme.of(context).focusColor,
                      ),
                      const SizedBox(width: 5),
                      CommonText(
                        text: '${provider.batteryStatus}%',
                      ),
                    ],
                  ),
                const SizedBox(width: 18.0),
                if (provider.wifiNetworkStatus != 'Unknown')
                  Row(
                    children: [
                      Icon(
                        Icons.wifi,
                        color: Theme.of(context).indicatorColor,
                      ),
                      const SizedBox(width: 5),
                      CommonText(
                        text: provider.wifiNetworkStatus,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('conversations')
                    .doc(provider.deviceId)
                    .collection('messages')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: provider.chatScrollController,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final message = documents[index];
                      return Column(
                        crossAxisAlignment: message['left'] == true
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: message['left'] == true
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0),
                                child: CommonText(
                                  text:message['sender'],
                                  style: TextStyle(
                                      fontWeight: message['sender'] == 'admin'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: message['sender'] == 'admin'
                                          ? Theme.of(context).primaryColor
                                          : null),
                                ),
                              ),
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
                                child: Column(
                                  children: [
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return message['left'] == true
                                            ? TypewriterTextAnimation(
                                                text: message['msg'],
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                constraints: constraints,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (message['shape'] != 'null')
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: message['shape'] == 'circle'
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: message['shape'] == 'container'
                                    ? BorderRadius.circular(12)
                                    : null,
                              ),
                              height: 150,
                              width: 150,
                            ),
                          if (message['images'].isNotEmpty && message['left'])
                            Wrap(
                              children: [
                                for (int a = 0; a < message['images'].length; a++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 150,
                                    width: 150,
                                    child: ImageDynamic(
                                      img: message['images'][a],
                                    ),
                                  )
                              ],
                            ),
                          if ((message['song'].toString() != 'null' &&
                                  message['song'].isNotEmpty) && message['song'].toString() != 'songName' &&
                              message['left'])
                            Center(
                              child: YouTubePlayerWidget(
                                videoId: message['song'],
                              ),
                            )
                        ],
                      );
                    },
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
                    selected: provider.selectedIndex == index ? true : false,
                    title:
                        CommonText(text: provider.filteredSuggestions[index]),
                    onTap: () {
                      provider.chatInputController.text =
                          provider.filteredSuggestions[index];
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
                    child: CallbackShortcuts(
                      bindings: <ShortcutActivator, VoidCallback>{
                        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
                          if (provider.filteredSuggestions.length >
                              provider.selectedIndex) {
                            provider.selectedIndex++;
                            provider.chatInputController.text = provider
                                .filteredSuggestions[provider.selectedIndex];
                          }
                        },
                        const SingleActivator(LogicalKeyboardKey.arrowDown):
                            () {
                          if (provider.filteredSuggestions.length >
                              provider.selectedIndex) {
                            provider.selectedIndex--;
                            provider.chatInputController.text = provider
                                .filteredSuggestions[provider.selectedIndex];
                          }
                        },
                      },
                      child: Focus(
                        autofocus: true,
                        child: TextField(
                          controller: provider.chatInputController,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: provider.chatGetReply,
                          style: FontStyles.body
                              .copyWith(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            hintStyle: FontStyles.body.copyWith(
                                color: Theme.of(context).primaryColor),
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await provider.chatGetReply();
                      setState(() {});
                    },
                    icon: const Icon(Icons.send_sharp),
                    color: Theme.of(context).indicatorColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
