import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDynamic extends StatelessWidget {
  final String img;

  const ImageDynamic({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AudioPlayer().play(AssetSource('audio/select_denied.mp3'));
      },
      child: img.contains('assets')
          ? Image.asset(
              img,
              fit: BoxFit.fitHeight,
            )
          : CachedNetworkImage(
              imageUrl: img,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported),
              fit: BoxFit.cover,
            ),
    );
  }
}
