import 'package:flutter/material.dart';

import '../utils/dynamic_image.dart';

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
        width: MediaQuery.of(context).size.width / 1.7,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
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
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Center(
                child: Hero(
                  tag: 'imageHero${widget.images[currentIndex]}',
                  child: ImageDynamic(
                    img: widget.images[currentIndex],
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.cover,
                  ),
                ),
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
                height: 70,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
