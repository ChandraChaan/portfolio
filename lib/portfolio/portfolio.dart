import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'dart:io';

import '../providers/user_info.dart';
import '../utils/dynamic_image.dart';
import '../utils/dynamic_size.dart';
import '../utils/font_style.dart';

class Portfolio extends StatelessWidget {
  final bool smallCard;

  const Portfolio({super.key, required this.smallCard});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserInfo>(context, listen: false).imagesListModifying();
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        return provider.imageLoaded
            ? Column(children: [
                const SizedBox(
                  height: (50),
                ),
                getTextStyle("Portfolio", FontWeight.bold,
                    Theme.of(context).primaryColor, 50),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: (6),
                  width: (120),
                  color: Theme.of(context).indicatorColor,
                ),
                const SizedBox(
                  height: (50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int c = 0; c < provider.imagesKeys.length; c++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          // width: (36),
                          // height: (40),
                          decoration: BoxDecoration(
                            color: provider.imageFilterString ==
                                    '${provider.imagesKeys[c]}'
                                ? Theme.of(context).indicatorColor
                                : null,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ),
                          child: TextButton(
                              onHover: (val) {},
                              onPressed: () {
                                provider.imageFilter(provider.imagesKeys[c]);
                              },
                              child: Text(
                                '${provider.imagesKeys[c]}'.toUpperCase(),
                                style: GoogleFonts.abyssinicaSil(
                                    textStyle: TextStyle(
                                        color: provider.imageFilterString ==
                                                '${provider.imagesKeys[c]}'
                                            ? Colors.white
                                            : Theme.of(context).indicatorColor,
                                        fontSize: 20)),
                              )),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: (35),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: smallCard
                      ? ListView.builder(
                          itemCount: provider.pImages.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    final images = List<String>.from(
                                        provider.pImages[index]['images']);
                                    return ImageDialog(images: images);
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ImageDynamic(
                                    img: "${provider.pImages[index]['img']}"),
                              ),
                            );
                          })
                      : GridView.builder(
                          itemCount: provider.pImages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18.0,
                                  childAspectRatio: 2,
                                  mainAxisSpacing: 18.0),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    final images = List<String>.from(
                                        provider.pImages[index]['images']);
                                    return ImageDialog(images: images);
                                  },
                                );
                              },
                              child: Container(
                                height: 170,
                                // width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ImageDynamic(
                                    img: "${provider.pImages[index]['img']}"),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ])
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// class ImageDialog extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   const ImageDialog({super.key, required this.images, this.initialIndex = 0});
//
//   @override
//   _ImageDialogState createState() => _ImageDialogState();
// }
//
// class _ImageDialogState extends State<ImageDialog> {
//   late int currentIndex;
//   late bool hasPrevious;
//   late bool hasNext;
//
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//     hasPrevious = currentIndex > 0;
//     hasNext = currentIndex < widget.images.length - 1;
//   }
//
//   void updateVisibility() {
//     setState(() {
//       hasPrevious = currentIndex > 0;
//       hasNext = currentIndex < widget.images.length - 1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Stack(
//               children: [
//                 ImageDynamic(
//                   img: widget.images[currentIndex],
//                   height: MediaQuery.of(context).size.height / 2.5,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   top: 16,
//                   right: 16,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       size: 32,
//                       color: Colors.black87,
//                     ),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//                 Positioned(
//                   top: 16,
//                   left: 16,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     child: Text(
//                       '${currentIndex + 1}/${widget.images.length}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: hasPrevious
//                         ? Center(
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_back,
//                                 size: 32,
//                                 color: Colors.black87,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   currentIndex--;
//                                   updateVisibility();
//                                 });
//                               },
//                             ),
//                           )
//                         : Container(),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: hasNext
//                         ? Center(
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_forward,
//                                 size: 32,
//                                 color: Colors.black87,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   currentIndex++;
//                                   updateVisibility();
//                                 });
//                               },
//                             ),
//                           )
//                         : Container(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ImageDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageDialog({Key? key, required this.images, this.initialIndex = 0})
      : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  late int currentIndex;
  late bool hasPrevious;
  late bool hasNext;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    hasPrevious = currentIndex > 0;
    hasNext = currentIndex < widget.images.length - 1;
  }

  void updateVisibility() {
    setState(() {
      hasPrevious = currentIndex > 0;
      hasNext = currentIndex < widget.images.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'imageHero${widget.images[currentIndex]}',
                  child: ImageDynamic(
                    img: widget.images[currentIndex],
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      '${currentIndex + 1}/${widget.images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: hasPrevious
                        ? Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 32,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          setState(() {
                            currentIndex--;
                            updateVisibility();
                          });
                        },
                      ),
                    )
                        : Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: hasNext
                        ? Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 32,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          setState(() {
                            currentIndex++;
                            updateVisibility();
                          });
                        },
                      ),
                    )
                        : Container(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        updateVisibility();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ImageDynamic(
                          img: widget.images[index],
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
