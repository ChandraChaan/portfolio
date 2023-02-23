// import 'package:flutter/material.dart';
//
//
// class ContactPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//        Scaffold(
//
//         body: ContactForm(),);
//
//
//   }
// }
//
// class ContactForm extends StatefulWidget {
//   @override
//   _ContactFormState createState() => _ContactFormState();
// }
//
// class _ContactFormState extends State<ContactForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 hintText: 'Enter your name',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 hintText: 'Enter your email',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 labelText: 'Message',
//                 hintText: 'Enter your message',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your message';
//                 }
//                 return null;
//               },
//               maxLines: null,
//             ),
//             SizedBox(height: 16.0),
//             RaisedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _submitForm();
//                 }
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _submitForm() {
//     final name = _nameController.text;
//     final email = _emailController.text;
//     final message = _messageController.text;
//
//     print('Name: $name');
//     print('Email: $email');
//     print('Message: $message');
//   }
// }
//
// RaisedButton({required Null Function() onPressed, required Text child}) {
// }
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_userName);
      debugPrint(_password);
      debugPrint(_confirmPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CONTACT US',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'it is a long established fact that a reader will \nbe distracted by the readable content of a \npage when looking at its layout.The point\nof using Lorem Ipsum is that it has a  more-\nless normal distribution of letters, as\nopposed to using Content here. ',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Full Name'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onChanged: (value) => _userEmail = value,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mail id'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 4) {
                                  return 'Username must be at least 4 characters in length';
                                }
                                return null;
                              },
                              onChanged: (value) => _userName = value,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Subject'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 8) {
                                  return 'Password must be at least 8 characters in length';
                                }
                                return null;
                              },
                              onChanged: (value) => _password = value,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 8) {
                                  return 'Password must be at least 280 characters in length\n';
                                }
                                return null;
                              },
                              onChanged: (value) => _password = value,
                              style: TextStyle(
                                fontSize: 18,
                                height: 4,
                              ),
                              maxLines: 3,
                              minLines: 2,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                }
                              },
                              child: const Text('SEND'),
                            ),

                            SizedBox(height: 35),
                            Padding(
                              padding: const EdgeInsets.only(left: 209.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Container(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_pin,
                                                    color: Colors.blueAccent,
                                                    size: 30.0,
                                                  ),
                                                  Text(
                                                    'ADDRESS',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '25, Dist town Strees Logn\nClifornia, Us',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Container(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.blueAccent,
                                                    size: 30.0,
                                                  ),
                                                  Text(
                                                    'PHONE',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '800 123 3456\n900 123 3457',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Container(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.email_outlined,
                                                    color: Colors.blueAccent,
                                                    size: 30.0,
                                                  ),
                                                  Text(
                                                    'EMAIL',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Fax: 800 123 3456\nEmail: info@themsbit.com',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 56),
                                      child: Row(
                                        children: const <Widget>[
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                            size: 24.0,
                                          ),
                                          Icon(
                                            Icons.audiotrack,
                                            color: Colors.green,
                                            size: 30.0,
                                          ),
                                          Icon(
                                            Icons.beach_access,
                                            color: Colors.blue,
                                            size: 36.0,
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
