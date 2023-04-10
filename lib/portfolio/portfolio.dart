import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'dart:io';

import '../providers/user_info.dart';
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
                getTextStyle("Portfolio", FontWeight.bold, Colors.black, 50),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: (6),
                  width: (120),
                  color: Colors.blue,
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
                            color: provider.imageFilterString == '${provider.imagesKeys[c]}' ? Colors.blueAccent : null,
                            border: Border.all(
                              width: 1,
                              color: Colors.blueAccent,
                            ),
                          ),
                          child: TextButton(
                              onHover: (val) {

                              },
                              onPressed: () {
                                provider.imageFilter(provider.imagesKeys[c]);
                              },
                              child: Text(
                                '${provider.imagesKeys[c]}'.toUpperCase(),
                                style: GoogleFonts.abyssinicaSil(
                                    textStyle: TextStyle(
                                        color: provider.imageFilterString == '${provider.imagesKeys[c]}' ? Colors.white : Colors.blueAccent,
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
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CachedNetworkImage(
                            imageUrl: "${provider.pImages[index]['img']}",
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                            fit: BoxFit.cover,
                          ),
                        );
                      }) :
                  GridView.builder(
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
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: "${provider.pImages[index]['img']}",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_not_supported),
                          fit: BoxFit.cover,
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
