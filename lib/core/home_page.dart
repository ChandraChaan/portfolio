import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfoli_web/ui/responsive_ui.dart';
import 'package:provider/provider.dart';
import '../animation_route/navigate_newpage.dart';
import '../providers/user_info.dart';
import 'home_ui/desktop_ui.dart';
import 'home_ui/mobile_ui.dart';
import 'home_ui/tablet_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? _scrollController;
  double? _scrollPosition;
  double? _maxscroll;
  double? _maxscrollpercentage;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      _maxscroll = _scrollController?.position.maxScrollExtent;

      _maxscrollpercentage =
          double.parse((_scrollPosition! / _maxscroll! * 1).toStringAsFixed(1));
    });
  }

  @override
  void initState() {
    super.initState();
    //get token
    _scrollController =
        Provider.of<UserInfo>(context, listen: false).scrollController;
    _scrollController?.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        scrollIndicator(context),
        const Expanded(
          child: ResponsiveWidget(
            mobile: MobileHomeUI(),
            tablet: TabletHomeUI(),
            desktop: DesktopHomeUI(),
          ),
        ),
      ],
    );
  }

  Widget scrollIndicator(BuildContext context) {
    return _maxscrollpercentage != null && _maxscrollpercentage != 0.00
        ? GestureDetector(
            onDoubleTap: () {
              Navigator.of(context).push(ChatGameRoute());
            },
            child: SizedBox(
              height: 20,
              child: LinearProgressIndicator(
                backgroundColor: Colors.cyan[100],
                color: Theme.of(context).indicatorColor,
                value: _maxscrollpercentage,
                // valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          )
        : const SizedBox();
  }
}
