import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import './QuestionTypeChoosingPage.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import 'StudentFavQuestionsDisplayingPage.dart';
import 'StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import './sideBarDrawer.dart';
import '../Models/QuestionModel.dart';
class StudentScoreDisplayWidget extends StatefulWidget {
   StudentScoreDisplayWidget(this.studentObject,{super.key});
   Student studentObject;
  @override
  State<StudentScoreDisplayWidget> createState() => _StudentScoreDisplayState();
}

class _StudentScoreDisplayState extends State<StudentScoreDisplayWidget> {
  @override
  Widget build(BuildContext context) {
   Student studentObject = widget.studentObject;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      constraints: const BoxConstraints.expand(),
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.2, 0.9, 0.4],
        colors: [
          Color.fromRGBO(255, 239, 186, 1),
          Color.fromRGBO(255, 255, 255, 1),
          Color.fromRGBO(255, 255, 255, 1),
        ],
      )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black38),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentMainLandingPageWidget(studentObject);
                        }),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
            ],
          ),

          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 0, right: 25, bottom: 1),
                                padding: const EdgeInsets.only(
                                    bottom: 0, top: 5, right: 5, left: 5),
                                child: const Text(
                                  "+25",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontFamily: 'digital',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'This Month',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'quickSand'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                          const Text(
                            "15654",
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "Students",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 0, right: 25, bottom: 1),
                                padding: const EdgeInsets.only(
                                    bottom: 0, top: 5, right: 5, left: 5),
                                child: const Text(
                                  "+25",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontFamily: 'digital',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'This Month',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'quickSand'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                           Text(
                            QuestionBox.getAllTheQuestions().toMap().length.toString(),
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: const TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "Tottal Questions",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    width: 350,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      borderOnForeground: true,
                      color: const Color(0xFFBCEAD5),
                      // color: const Color.fromARGB(255, 188, 243, 209),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 0, right: 25, bottom: 1),
                                padding: const EdgeInsets.only(
                                    bottom: 0, top: 5, right: 5, left: 5),
                                child: const Text(
                                  "+25",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontFamily: 'digital',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'This Month',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'quickSand'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 15)),
                          const Text(
                            "15654",
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: TextStyle(
                                letterSpacing: 5,
                                fontFamilyFallback: ['OpenSans'],
                                wordSpacing: 545,
                                // color: Color.fromARGB(255, 47, 161, 51),
                                color: Color.fromARGB(255, 87, 129, 113),
                                fontSize: 70,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: const Text(
                              "Exams Taken",
                              style: TextStyle(
                                  fontFamily: 'quickSand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ],)
           
    );    
       
       
}}
