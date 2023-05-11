import 'package:flutter/material.dart';

// class Secondpage extends StatefulWidget {
//   const Secondpage({Key? key}) : super(key: key);
//
//   @override
//   State<Secondpage> createState() => _SecondpageState();
// }
//
// class _SecondpageState extends State<Secondpage> {
//   TextEditingController inputController = new TextEditingController();
//   String _text = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wellcome to timepass game'),
//       ),
//       body: Row(
//         children: [
//           // side menu
//           Expanded(
//             flex: 9,
//             child: Column(
//               children: [
//                 SizedBox(height: 60,),
//
//                 TextField(
//                   controller: inputController,
//                   decoration: InputDecoration(
//                     hintText: "enter the name",
//                     border: OutlineInputBorder(),
//                     // labelText: 'Enter a message',
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _text = inputController.text;
//                     });
//                   },
//                   child: Text(
//                     'click me',
//                     style:
//                         TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Text(
//                   '$_text',
//                   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
//                 ),
//
//                 // const SizedBox(height: 30),
//               ],
//             ),
//           ),
//
//           // body
//           Expanded(flex: 3, child: Text('hii')),
//         ],
//       ),
//     );
//   }
//
// }

class WhatsAppChatUI extends StatefulWidget {
  @override
  _WhatsAppChatUIState createState() => _WhatsAppChatUIState();
}

class _WhatsAppChatUIState extends State<WhatsAppChatUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/howto/img_avatar.png'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Jane Doe',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'),
                  ),
                  title: Text('Jane Doe'),
                  subtitle: Text('Hello, how are you?'),
                  trailing: Text('12:00 pm'),
                );
              },
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
