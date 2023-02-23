import 'package:flutter/material.dart';

class Expiriencescreen extends StatefulWidget {
  const Expiriencescreen({Key? key}) : super(key: key);

  @override
  State<Expiriencescreen> createState() => _ExpiriencescreenState();
}

class _ExpiriencescreenState extends State<Expiriencescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 328.0,right: 180,top: 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EXPERIENCE',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 17,),

                Container(

                  height: 7,
                  width: 45,
                  color: Colors.blue,
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 49),
                  child: Container(
                    margin: EdgeInsets.only(right: 10), // ***

                    height: 270,
                    width: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.gps_fixed_sharp,
                                  color: Colors.blueAccent,
                                  size: 27,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    'Senior Web Developer',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text(
                            'Capitalize on low hanging fruit to\nidentify a ballpark value added\nactivity to beta test. Override the\ndigital divide with additional\nclickthroughs from DevOps.\nNanotechnology immersion along\nthe information highway will close\nthe loop on focusing solely on the\nbottom line.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'March 2019 - Present',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent),
                          ),


                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 1,
                          // spreadRadius: 1,


                          offset: Offset(1.5, 1.5),


                        )
                      ],



                      border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 49),
                  child: Container(
                    margin: EdgeInsets.only(right: 10), // ***

                    height: 270,
                    width: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.desktop_windows_sharp,
                                  color: Colors.orange,
                                  size: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Web Developer',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text(
                            'Capitalize on low hanging fruit to\nidentify a ballpark value added\nactivity to beta test. Override the\ndigital divide with additional\nclickthroughs from DevOps.\nNanotechnology immersion along\nthe information highway will close\nthe loop on focusing solely on the\nbottom line.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'Decembe 2018 - March 2019',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent),
                          ),


                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange,
                          blurRadius: 1,
                          // spreadRadius: 1,


                          offset: Offset(1.5, 1.5),


                        )
                      ],



                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 49),
                  child: Container(
                    margin: EdgeInsets.only(right: 10), // ***

                    height: 270,
                    width: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.green,
                                  size: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    'Junior Web Developer',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text(
                            'Capitalize on low hanging fruit to\nidentify a ballpark value added\nactivity to beta test. Override the\ndigital divide with additional\nclickthroughs from DevOps.\nNanotechnology immersion along\nthe information highway will close\nthe loop on focusing solely on the\nbottom line.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'July 2017 - December 2018',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent),
                          ),


                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 1,
                          // spreadRadius: 1,


                          offset: Offset(1.5, 1.5),


                        )
                      ],



                      border: Border.all(
                        color: Colors.greenAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 49),
                  child: Container(
                    margin: EdgeInsets.only(right: 10), // ***

                    height: 270,
                    width: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.panorama_outlined,
                                  color: Colors.blue,
                                  size: 30.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    'Web Design Intern',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text(
                            'Capitalize on low hanging fruit to\nidentify a ballpark value added\nactivity to beta test. Override the\ndigital divide with additional\nclickthroughs from DevOps.\nNanotechnology immersion along\nthe information highway will close\nthe loop on focusing solely on the\nbottom line.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'September 2018 - June 2019',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent),
                          ),


                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 1,
                          // spreadRadius: 1,


                          offset: Offset(1.5, 1.5),


                        )
                      ],



                      border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
