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
    return Consumer<UserInfo>(
      builder: (context, provider, child) {
        provider.imagesListModifiying();
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
                                // Show the dialog using ImageDialog
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    final images = [
                                      "assets/backGround-image.jpg",
                                      "assets/background_image.jpg",
                                      "assets/profile_image.jpg",
// Add more images as needed
                                    ];

                                    return ImageDialog(images: images);
                                  },
                                );

                                /*  showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      final longList = List<Widget>.generate(
                                          100, (i) => Text("Item $i"));
                                      return Dialog(
                                        child: ImageDynamic(
                                            img:
                                                "${provider.pImages[index]['img']}"),
                                      );
                                    });*/
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
                                    final images = [
                                      "assets/backGround-image.jpg",
                                      "assets/background_image.jpg",
                                      "assets/profile_image.jpg",
// Add more images as needed
                                    ];

                                    return ImageDialog(images: images);
                                  },
                                );
                                // this is start the code
                                // showDialog(
                                //     barrierDismissible: true,
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       final longList = List<Widget>.generate(
                                //           100, (i) => Text("Item $i"));
                                //       return Dialog(
                                //         child: ImageDynamic(
                                //             img:
                                //                 "${provider.pImages[index]['img']}"),
                                //       );
                                //     });
                                // this is ending the code
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

class ImageDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  ImageDialog({required this.images, this.initialIndex = 0});

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
      insetPadding: EdgeInsets.zero,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Flexible(
                fit: FlexFit.loose,
                child: ImageDynamic(img: widget.images[currentIndex])),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: hasPrevious
                        ? IconButton(
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
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: hasNext
                        ? IconButton(
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
                          )
                        : Container(),
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
