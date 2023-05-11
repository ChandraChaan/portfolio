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

// class WhatsAppChatUI extends StatefulWidget {
//   @override
//   _WhatsAppChatUIState createState() => _WhatsAppChatUIState();
// }

// class _WhatsAppChatUIState extends State<WhatsAppChatUI> {
//   TextEditingController inputController = new TextEditingController();
//   String _text = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0.0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                   'https://www.w3schools.com/howto/img_avatar.png'),
//             ),
//             SizedBox(
//               width: 10.0,
//             ),
//             Text(
//               'Jane Doe',
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.videocam),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                         'https://www.w3schools.com/howto/img_avatar.png'),
//                   ),
//                   title: Text('Jane Doe'),
//                   subtitle: Text('Hello, how are you?'),
//                   trailing: Text('12:00 pm'),
//                 );
//               },
//             ),
//           ),
//           Text(
//             '$_text',
//             style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
//           ),
//
//           Divider(
//             height: 1.0,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.attach_file),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     setState(() {
//                       _text = inputController.text;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class WhatsAppChat extends StatefulWidget {
  @override
  State<WhatsAppChat> createState() => _WhatsAppChatState();
}

class _WhatsAppChatState extends State<WhatsAppChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 60.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/10.jpg'),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'last seen today at 11:54 AM',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              children: [
                ChatMessage(
                  message: 'Hey, how are you?',
                  isMe: true,
                  time: '11:50 AM',
                ),
                ChatMessage(
                  message: 'I am doing good, thanks. What about you?',
                  isMe: false,
                  time: '11:52 AM',
                ),
                ChatMessage(
                  message: 'I am fine too.',
                  isMe: true,
                  time: '11:54 AM',
                ),
                ChatMessage(
                  message: 'What are your plans for today?',
                  isMe: false,
                  time: '11:56 AM',
                ),
                ChatMessage(
                  message: 'Nothing much, just chilling at home. What about you?',
                  isMe: true,
                  time: '11:58 AM',
                ),
                ChatMessage(
                  message: 'I have a meeting at 2 PM. Other than that, nothing planned.',
                  isMe: false,
                  time: '12:00 PM',
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.insert_emoticon),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  ChatMessage({required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}


