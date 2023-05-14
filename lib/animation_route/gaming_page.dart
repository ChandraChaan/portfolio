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
  bool showTable = false;
  bool container = false;
  bool circle = false;
  int rNumber = 0;

  getReply() {
    String rText = 'Ok';
    String userText = inputController.text.toLowerCase();

    if (inputController.text.isNumeric) {
      rNumber = int.parse(inputController.text);
      rText = (2 * rNumber).toString();
      showTable = true;
       container = false;
       circle = false;
    } else {
      showTable = false;
      List name = inputController.text.split(' ');
      if (name[0].toString().toLowerCase() == 'create') {
        if (name[1].toString().toLowerCase() == 'container') {
          container = true;
          circle = false;
        } else if (name[1].toString().toLowerCase() == 'circle') {
          container = false;
          circle = true;
        } else {
          container = false;
          circle = false;
          rText = "I didn\'t get";
        }
      }
      else{
        container = false;
        circle = false;
      }
      if (userText == "hello") {
        rText = "Hi";
      }
      if (userText == "inka") {
        rText = "Cheppu";
      }
      if (userText == "yemi") {
        rText = "yenti yemi";
      }
      if (userText == "how are you") {
        rText = "Fine";
      }
      if (userText == "had you dinner") {
        rText = "Yes Done";
      }
      if (userText == "where are you") {
        rText = "Iam At home";
      }
      if (userText == "whats up") {
        rText = "Nothing";
      }
      if (userText == "love you") {
        rText = "Love You Too";
      }
      if (userText == "are you working") {
        rText = "Yes";
      }
      if (userText == "what special today") {
        rText = "Chicken";
      }
      if (userText == "do you have love") {
        rText = "Your my love";
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
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
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
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 150,
                              child: Center(child: Text(replyTest)))),
                      if (circle || container)
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: circle
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: container
                                    ? BorderRadius.circular(12)
                                    : null,
                              ),
                              height: 150,
                              width: 150,
                              // child: Center(child: Text(replyTest))
                            )),
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
          if (showTable)
            // body
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int a = 1; a < 11; a++)
                      Text('$_text x $a = ${(a * rNumber).toString()}')
                    // Text('$_text'
                    //     'x ${a.toString()} = ${(int.parse(inputController.text) * a).toString()}'),
                  ],
                )),
        ],
      ),
    );
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}
