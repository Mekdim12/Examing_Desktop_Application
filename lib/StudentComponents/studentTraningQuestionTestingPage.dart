import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import './sideBarDrawer.dart';
import '../Models/QuestionModel.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentTraningQuestionTestingPage.dart';
import 'package:hive/hive.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import 'package:hive/hive.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentTraningQuestionTestingPage.dart';

class StudentQuestionTypeSpecificTestingPageWidget extends StatefulWidget {
  StudentQuestionTypeSpecificTestingPageWidget(this.studentObject, this.flag_for_page, this.questionType, this.questionIndex, {super.key});

    String flag_for_page; // menu identifier
	int questionIndex; // for displaying the question and marking active on sidebar
    String questionType; // 1-9 question type
    Student studentObject; // student info tracking

  @override
  State<StudentQuestionTypeSpecificTestingPageWidget> createState() => StudentQuestionTypeSpecificTestingPageState();
}

class StudentQuestionTypeSpecificTestingPageState extends State<StudentQuestionTypeSpecificTestingPageWidget> {
  @override
  Widget build(BuildContext context) {

	Student object = widget.studentObject;
	String flag_for_page = widget.flag_for_page;
	String questionType = widget.questionType;
	int questionIndex = widget.questionIndex;

	List questionTypeItems = ['ሞተርሳይክል',
                              'አዉቶሞቢል',
                              'ታክሲ 1',
                              'ታክሲ 2',
                              'ደረቅ 1',
                              'ደረቅ 2', 
                              'ደረቅ 3',
                              'ህዝብ 1',
                              'ህዝብ 2'
                        ];

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Scaffold(
        drawer:  StudentPageSidebarDrawerWidget(object, flag_for_page, questionType, questionIndex),
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: Color.fromARGB(165, 96, 125, 139),
          title: const Text(
            'ፈተና መለማመጃ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
         
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // color: const Color(0xFFF5EBE0),
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
             
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1600,
                      height: 800,
                      child: Column(
                        children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1600,
                      height: 750,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
																	'${questionTypeItems[int.parse(questionType)  - 1 ] }',
																	style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),),
                                  Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                  Container(child: Text('የሙከራ ጥያቄ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),),)
                              ],
                            )
                          ),
                          Container(
                            width: 1600,
                            height: 700,
                            child: Card(
                              color: Color.fromARGB(29, 96, 125, 139),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: Color.fromRGBO(255, 239, 186, 1),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 100 ),
                                      height: 50,
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(child: Text("00", style: TextStyle(fontFamily: 'digital', fontWeight: FontWeight.bold, fontSize: 50,color: Colors.teal),),),
                                          Container(child: Text(":", style: TextStyle(fontFamily: 'digital',fontWeight: FontWeight.bold, fontSize: 30,color: Colors.blue),),),
                                          Container(child: Text("00", style: TextStyle(fontFamily: 'digital',fontWeight: FontWeight.bold, fontSize: 50,color: Colors.teal),),)
                                        ],
                                      ),
                                    ),
                                    
                                    Container(
                                      width: 1600,
                                      decoration:BoxDecoration(
                                        //  color:Colors.white38,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 150,
                                     
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      child:Row(
                                        children: [
                                            Container(
                                              height: 150,
                                               
                                              padding: EdgeInsets.zero,
                                              margin: EdgeInsets.zero,
                                              child:Column(  
                                                  children: [
                                                    Container(
                                                      
                                                      decoration: BoxDecoration(
                                                        color:Colors.white54,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15))
                                                    ),
                                                      height: 75,
                                                      width: 150,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                             Text('1.',style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 35),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    Container(
                                                      height:75,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('ጥያቄ ቁ',style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 14),)],
                                                    ),
                                                      
                                                    ),
                                                  ],
                                              ),

                                          ),
                                        
                                           Container(
                                            margin: EdgeInsets.symmetric(horizontal: 1),
                                             
                                              padding: EdgeInsets.all(15),
                                              height:150,
                                              width: 1400,
                                              decoration: BoxDecoration(
                                                color:Colors.white38,
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight:   Radius.circular(15))
                                              ),
                                              child: SingleChildScrollView(child:Text('some', style: TextStyle(fontSize: 22, fontFamily: 'openSans', fontWeight: FontWeight.bold, color: Colors.black),),),
                                            )
                                        ],
                                      ),
                                    ),


                                    Container(
                                      child:Column(
                                          children: [
                                             Container(
                                                margin: EdgeInsets.symmetric(vertical: 25),
                                                child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          // color:Colors.red,
                                                          child: TextButton(
                                                            onPressed: (){},
                                                            child: Container(
                                                              width: 650,
                                                              height: 150,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                      children : [
                                                                        Container(
                                                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                                                          alignment: Alignment.center,
                                                                          width:50,
                                                                          height: 50,
                                                                          decoration: BoxDecoration(
                                                                            color: Color.fromRGBO(200, 104, 25, 1),
                                                                            borderRadius: BorderRadius.circular(50)
                                                                          ),
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Text('A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),

                                                                        Container(
                                                                           width: 550,
																		   height: 150,
																		   child: Text('ss'),
																		   decoration: BoxDecoration(
																			border: Border.all(),
																		   ),),

                                                                      ]
                                                                  )
                                                                ],
                                                              ),
                                                            ))
                                                        ),


                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.yellow
                                                        ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 25),
                                                child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.green
                                                        ),


                                                        Container(
                                                          height: 150,
                                                          width: 650,
                                                          color:Colors.blue
                                                        ),
                                                  ],
                                                ),
                                              )
                                          ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          )
                        ],
                      )),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }
}


/**
   Stack(
								children: <Widget>[
									Container(
									width: 1600,
									height: 750,
									margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
									padding: EdgeInsets.only(bottom: 10),
									decoration: BoxDecoration(
										border: Border.all(
											color: Colors.blueGrey, width: 2),
										borderRadius: BorderRadius.circular(15),
										shape: BoxShape.rectangle,
									),
									),
									Container(
												width: 1600,
												height: 700,
												child: Column(
													children: [
															Positioned(
																left: 50,
																top: 12,
																child:  Container(
																	padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
																	color:Color.fromRGBO(255, 239, 186, 0.751),
																	child: Text(
																	'${questionTypeItems[int.parse(questionType)  - 1 ] }',
																	style: TextStyle(color: Colors.black, fontSize: 20),
																	),
																),
															)

													],
												),
										)
									
								  ],
								)          
                      
 */