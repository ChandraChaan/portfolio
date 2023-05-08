import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
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
              flex: 6,
              child:
              Column(
                children: [
                  TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a message',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      setState(){
                        _text = inputController.text;
                      }
                    },
                    child: const Text('Enabled'),
                  ),
    Text('$_text'),
                ],
              ),


            ),

            // body
            Expanded(flex: 4,
                child: Text('hii')),
          ],
        )
        // const Center(
        //   child: Text('This is the Timepass game'),
        // ),
        );
  }

