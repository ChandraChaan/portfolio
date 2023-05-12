import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = new TextEditingController();
  String _text = "hello";
  String replytest = "hello";

  getReply() {
    String rText = 'ok';
    if (inputController.text == "inka") {rText= "cheppu";}
    if (inputController.text == "2") {rText= "cheppu";}
    setState(() {
      replytest = rText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome to timepass game'),
      ),
      body: Row(
        children: [
          // side menu
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 150,
                              child: Center(child: Text(_text)))),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 150,
                              child: Center(child: Text(replytest)))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (inputController.text.isNotEmpty) {
                            getReply();

                            setState(() {
                              _text = inputController.text;
                              inputController.clear();
                            });
                          }
                        },
                        icon: const Icon(Icons.send_sharp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // body
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
