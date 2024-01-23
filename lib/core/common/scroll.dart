// import 'dart:js_util';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


void scrollSmooth(BuildContext context) {
  // if (Provider.of<UserInfo>(context, listen: false).musicMode) {
  //   AudioPlayer().play(AssetSource('audio/decide.mp3'));
  // }
  Scrollable.ensureVisible(context,
      duration: const Duration(seconds: 1), curve: Curves.easeIn);
}

// class ScrollIndicator extends StatefulWidget {
//   const ScrollIndicator({super.key});
//
//   @override
//   State<ScrollIndicator> createState() => _ScrollIndicatorState();
// }
//
// class _ScrollIndicatorState extends State<ScrollIndicator> {
//   ScrollController? _scrollController;
//   double? _scrollPosition;
//   double? _maxscroll;
//   double? _maxscrollpercentage;
//
//   _scrollListener() {
//     setState(() {
//       _scrollPosition = _scrollController?.position.pixels;
//       _maxscroll = _scrollController?.position.maxScrollExtent;
//
//       _maxscrollpercentage =
//           double.parse((_scrollPosition! / _maxscroll! * 1).toStringAsFixed(1));
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     //get token
//     _scrollController =
//         Provider.of<UserInfo>(context, listen: false).scrollController;
//     _scrollController?.addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     _scrollController?.removeListener(_scrollListener);
//     _scrollController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _maxscrollpercentage != null && _maxscrollpercentage != 0.00
//         ? GestureDetector(
//             onDoubleTap: () {
//               Navigator.of(context).push(ChatGameRoute());
//             },
//             child: SizedBox(
//               height: 20,
//               child: LinearProgressIndicator(
//                 backgroundColor: Colors.cyan[100],
//                 color: Theme.of(context).indicatorColor,
//                 value: _maxscrollpercentage,
//                 // valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//               ),
//             ),
//           )
//         : const SizedBox();
//   }
// }
