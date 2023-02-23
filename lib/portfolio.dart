import 'package:flutter/material.dart';

class ImageColumn extends StatefulWidget {
  @override
  _ImageColumnState createState() => _ImageColumnState();
}

class _ImageColumnState extends State<ImageColumn> {
  bool _showImages = false;

  void _toggleImages() {
    setState(() {
      _showImages = !_showImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PORTFOLIO',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Container(
                  color: Colors.blueAccent,

                  height: 7,
                  width: 45,

                  // color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Container(
                    child: TextButton(
                      onPressed: _toggleImages,
                      child: Text('All'),
                    ),
                    width: 40,
                    height: 29,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      child: TextButton(
                        onPressed: _toggleImages,
                        child: Text('WEB DESIGN'),
                      ),
                      width: 110,
                      height: 29,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: TextButton(
                      onPressed: _toggleImages,
                      child: Text('MOBILE APP'),
                    ),
                    width: 110,
                    height: 29,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      child: TextButton(
                        onPressed: _toggleImages,
                        child: Text('GRAPHICS DESIGN'),
                      ),
                      width: 140,
                      height: 29,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _showImages
                  ? Column(
                      children: [
                        Image.network('https://picsum.photos/200'),
                        SizedBox(
                          height: 15,
                        ),
                        Image.network('https://picsum.photos/200'),
                        SizedBox(
                          height: 15,
                        ),
                        Image.network('https://picsum.photos/200'),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
