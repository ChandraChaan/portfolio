import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = new TextEditingController();
  String _text = "hello";

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
                    Alin(

                    alignment: Alignment.bottomRight, child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: isMe ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),

                          height: 30,
                          width: 50,
                          child: Center(child: Text(_text)))),

                    Align(
                        alignment: Alignment.bottomLeft, child: Container(

                        height: 30, width: 50, color: Colors.grey,
                        child: Center(child: Text(_text)))),
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
                          if (inputController.text.isNotEmpty)
                            setState(() {
                              _text = inputController.text;
                              inputController.clear();
                            });
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

class BubbleChat extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  BubbleChat({required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
