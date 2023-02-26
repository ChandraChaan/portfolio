import 'package:flutter/material.dart';

import 'contactscreen.dart';
import 'experience screen.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({Key? key}) : super(key: key);

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int c=0;c<5;c++)
                      SizedBox(
                        height: 25,
                          child: Text('HOME',style: TextStyle(color: Colors.white),)),
                    ],
                  ),
                  color: Colors.blue,)),

            Expanded(
              flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Expiriencescreen(),
                      HomePage()
                    ],
                  )
                ),

            ),
          ],
        ),
      ),
    );
  }
}
