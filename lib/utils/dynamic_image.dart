import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDynamic extends StatefulWidget {
  final String img;

  const ImageDynamic({Key? key, required this.img}) : super(key: key);

  @override
  _ImageDynamicState createState() => _ImageDynamicState();
}

class _ImageDynamicState extends State<ImageDynamic> {
  bool _loadingFailed = false;

  @override
  Widget build(BuildContext context) {
    return widget.img.contains('assets')
        ? Image.asset(
            widget.img,
            fit: BoxFit.fitHeight,
          )
        : _loadingFailed
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Failed to load image.', textAlign:TextAlign.center),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _loadingFailed = false;
                      });
                    },
                    child: const Text('Reload'),
                  ),
                ],
              )
            : CachedNetworkImage(
                imageUrl: widget.img,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _loadingFailed = true;
                    });
                  });
                  return const Icon(Icons.image_not_supported);
                },
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  );
                },
                httpHeaders: const {},
              );
  }
}
