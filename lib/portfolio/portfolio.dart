import 'package:flutter/material.dart';
import 'package:portfoli_web/utils/font_style.dart';
import 'package:provider/provider.dart';
import '../providers/user_info.dart';
import '../utils/dynamic_image.dart';
import 'image_dailog.dart';

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
                const CommonText(text: "Portfolio", fontWeight: FontWeight.bold, fontSize: 12,),
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
                                style: TextStyle(
                                        color: provider.imageFilterString ==
                                                '${provider.imagesKeys[c]}'
                                            ? Colors.white
                                            : Theme.of(context).indicatorColor,
                                        fontSize: 20),
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
