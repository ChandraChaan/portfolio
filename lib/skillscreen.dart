import 'package:flutter/material.dart';
import 'dart:ui';

//
class Skillscreen extends StatefulWidget {
  const Skillscreen({Key? key}) : super(key: key);

  @override
  State<Skillscreen> createState() => _SkillscreenState();
}

class _SkillscreenState extends State<Skillscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.gizbot.com/webp/fit-in/img/600x388/2018/06/how-to-play-youtube-videos-in-the-background-on-your-smartphone-1529565842.jpg'),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'CODING SKILLS',
                      style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),


                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(
                            Icons.account_balance_wallet_sharp,
                            color: Colors.blueAccent,
                            size: 80.0,
                          ),

                          Text(
                            '84%',
                            style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'HTML5',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 200,
                      color: Colors.black.withOpacity(0.5),


                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 300,
                      height: 200,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(
                            Icons.camera,
                            color: Colors.blueAccent,
                            size: 80.0,
                          ),

                          Text(
                            '95%',
                            style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CSS3',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),


                    ),
                    SizedBox(height: 10,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(
                            Icons.label_off_sharp,
                            color: Colors.blueAccent,
                            size: 80.0,
                          ),

                          Text(
                            '65%',
                            style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'JQuery',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 200,
                      color: Colors.black.withOpacity(0.5),


                    ),
                    SizedBox(height: 10,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Icon(
                            Icons.language_rounded,
                            color: Colors.blueAccent,
                            size: 80.0,
                          ),

                          Text(
                            '89%',
                            style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'PHP',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 200,
                      color: Colors.black.withOpacity(0.5),


                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );


  }
}




