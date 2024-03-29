import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Models/ScoreModel.dart';
import '../Models/StudentModels.dart';
import './sideBarDrawer.dart';
import '../Models/QuestionModel.dart';
import 'Admin_login_page.dart';
class AdminLandingPageWidget extends StatefulWidget {
  const AdminLandingPageWidget({super.key});

  @override
  State<AdminLandingPageWidget> createState() => AdminLandingPageState();
}

class AdminLandingPageState extends State<AdminLandingPageWidget> {
  
  List<Color> listoFColor = [
    const Color(0xFFEC6B56),
    const Color(0xFF47B39C),
    const Color(0xFFFFC154),
  ];

  @override
  Widget build(BuildContext context) {

    int totalStuentCount = StudentBox.getAllTheStudentsInfo().length;
    
    Box<StudentScoreModel> studScore = StudentScoreBox.getAllStudentsScore();
    int totalExamCount = studScore.length;

    int failedExam = 0;
    int passedExam = 0;
    int notFinishedExam = 0;

    StudentScoreBox.getAllStudentsScore().toMap().forEach((key,value){
        // List s = value.studentScore.values.first;
        if(value.studentScore.values.first[5]){
              if(value.studentScore.values.first[4]){
                passedExam++;
              }else{
                failedExam++;
              }
        }else{
          notFinishedExam ++;
        }
    });

    Map<String, double> exampValues = {
    "Failed Exams": failedExam.toDouble(),
    "Passed Exams": passedExam.toDouble(),
    "Not Finished Exams": notFinishedExam.toDouble()
  };

    

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Scaffold(
        drawer: const SidebarDrawerWidget(1),
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: const Color(0xFF65647C),
          title: const Text(
            'Manage Question',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IconButton(
                onPressed: () {
                   Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) {
                  return AdminLoginPageWidget();
                }),
              );
                },
                icon: const Icon(Icons.logout),
                iconSize: 35,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // color: const Color(0xFFF5EBE0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundEntrance.jpg'),
            ),
          ),
          child: Column(
            children: [
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
                           Text(
                            "${totalStuentCount}",
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
                              "Total Students",
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
                              "Total Questions",
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
                            "${totalExamCount}",
                            selectionColor: Color.fromARGB(255, 188, 243, 209),
                            style: TextStyle(
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
              Center(
                child: PieChart(
                  legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(color: Colors.white),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: true),
                  ringStrokeWidth: 45,
                  chartType: ChartType.disc,
                  dataMap: exampValues,
                  colorList: listoFColor,
                  chartRadius: MediaQuery.of(context).size.width / 5,
                  centerText: 'Exams Informatoin',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
