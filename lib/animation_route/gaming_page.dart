import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController inputController = new TextEditingController();
  String _text = "";

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
            flex: 9,
            child: Column(
              children: [
                SizedBox(height: 60,),

                TextField(
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: "enter the name",
                    border: OutlineInputBorder(),
                    // labelText: 'Enter a message',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _text = inputController.text;
                    });
                  },
                  child: Text(
                    'click me',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '$_text',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),

                // const SizedBox(height: 30),
              ],
            ),
          ),

          // body
          Expanded(flex: 3, child: Text('hii')),
        ],
      ),
    );
  }

}
