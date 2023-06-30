import 'package:flutter/material.dart';
import 'package:portfoli_web/providers/user_info.dart';


import 'package:provider/provider.dart';

import '../about/about.dart';

class NameVerificationPage extends StatefulWidget {
  const NameVerificationPage({super.key});

  @override
  _NameVerificationPageState createState() => _NameVerificationPageState();
}

class _NameVerificationPageState extends State<NameVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: _name,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: SizedBox(
                    height: 16.0,
                    child: Text(
                      'Enter one word for understanding system',
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (context.read<UserInfo>().userDeatile(_name.text)) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const About()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Expanded(
                              child: AlertDialog(
                                title: Text(
                                    'Welcome ${_name.text.split(' ').first}'),
                                content: const Text(
                                    'do not rush, slowly read caption below'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok'))
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
