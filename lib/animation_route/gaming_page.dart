import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = TextEditingController();
  String _text = "Type Something";
  String replyTest = "See The Result";

  getReply() {
    String rText = 'Ok';
    if (inputController.text.isNumeric) {
      rText = (2 * int.parse(inputController.text)).toString();
    } else {
      if (inputController.text == "Hello!") {
        rText = "Hi";
      }
      if (inputController.text == "How Are You") {
        rText = "Fine";
      }
      if (inputController.text == "Had You Dinner") {
        rText = "Yes Done";
      }
      if (inputController.text == "Where are You") {
        rText = "Iam At home";
      }
      if (inputController.text == "Where are You") {
        rText = "Iam At home";
      }
      if (inputController.text == "Whatsup") {
        rText = "Nothing";
      }
      if (inputController.text == "Whatsup") {
        rText = "Nothing";
      }
      if (inputController.text == "Love You") {
        rText = "Love You Too";
      }
      if (inputController.text == "Are You Working") {
        rText = "Yes";
      }
      if (inputController.text == "What Special Today") {
        rText = "Chicken";
      }
      if (inputController.text == "Do You Have Love") {
        rText = "Yes";
      }
    }
    setState(() {
      replyTest = rText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to time pass game'),
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
                              child: Center(child: Text(replyTest)))),
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

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}
