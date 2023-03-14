import 'package:flutter/material.dart';
import 'package:originalmorals/about/about.dart';
import 'package:originalmorals/providers/user_info.dart';
import 'package:originalmorals/user_information.dart';

import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => About()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Expanded(
                              child: AlertDialog(
                                title: Text(
                                    'Welcome ${_name.text.split(' ').first}'),
                                content: Text(
                                    'do not rush, slowly read caption below'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'))
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
