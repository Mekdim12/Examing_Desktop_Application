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
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'StudentQustionTtypeSpecficList.dart';
import '../Models/QuestionModel.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import './QuestionTypeChoosingPage.dart';
import './studentTraningQuestionTestingPage.dart';



class StudentPageSidebarDrawerWidget extends StatefulWidget {
   StudentPageSidebarDrawerWidget(this.studentObject, this.flag_for_page, this.questionType, this.questionIndex, {super.key});


  int questionIndex; // for displaying the question and marking active on sidebar
  Student studentObject; // student info tracking
  String questionType; // 1-9 question type
  String flag_for_page; // menu identifier

  @override
  State<StudentPageSidebarDrawerWidget> createState() => _StudentSidebarDrawerState();
}

class _StudentSidebarDrawerState extends State<StudentPageSidebarDrawerWidget> {

  List<Question> ListOfQuestions(String questionType){
    
    List<Question>  resolvedQuestionItems = [];
    Box<Question> db = QuestionBox.getAllTheQuestions();
    Box<QuestionTypeModel> dbs = QuestionTypeBox.getAllTheQuestionsTypes();

    dbs.toMap().forEach((key, value) { 
        if (value.question_type_items.values.toList()[0].toString() == questionType){
          
          db.toMap().forEach((key, val) {
            if(value.question_type_items.keys.toList()[0].toString() == val.key.toString()){
              resolvedQuestionItems.add(val);
            }
          });
        }
    });
    
    
    return resolvedQuestionItems;
  }
  @override
  Widget build(BuildContext context) {
  
    Student object = widget.studentObject;
    String flag_for_page = widget.flag_for_page;
    String questionType = widget.questionType;
    int questionIndex = widget.questionIndex;

   List<Question> listQuestionObject =  ListOfQuestions(questionType);
    
    return Drawer(
      
      width: 380,
      shadowColor: const Color(0xFF65647C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      elevation: 2,
      child: Scaffold(
        backgroundColor: const	Color.fromRGBO(255, 239, 186, 0.677),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              width: double.infinity,
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        hoverColor: Colors.blueGrey,
                        focusColor: Colors.blueGrey,
                        padding: EdgeInsets.all(0),
                        splashRadius: 50,
                        splashColor: Colors.amber,
                       
                        style: const ButtonStyle(

                          alignment: Alignment.topCenter,
                          elevation: MaterialStatePropertyAll(12),
                        ),
                        color: const Color(0xFFF5EBE0),
                        // iconSize: 25,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.all(4),
                    child: const Text(
                      "የጥያቄዎች ዝርዝር",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ), 

            Container(margin: EdgeInsets.only(bottom: 5),),

            SizedBox(
              height: 700,
                 child :ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(), // new
                  itemCount: listQuestionObject.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container( 
                      margin: EdgeInsets.symmetric(vertical: 7),
                      child:TextButton(     
                      onPressed: (){}, 
                      child: Container(
                      
                        padding: EdgeInsets.all(10),
                      height: 45,
                      decoration:  BoxDecoration(
                        color: (listQuestionObject[index].exam_type != 1)?  Color.fromRGBO(186, 175, 142, 0.51): Color.fromRGBO(209, 208, 205, 0.218),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(child:Text('${index+1} :' , style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'openSans', fontSize: 17, color: Colors.blueGrey),),),
                          Container(margin: EdgeInsets.symmetric(horizontal: 5),),       
                          Container(
                            child:Text( ('${listQuestionObject[index].question.values.toList()[0].toString()}'.length > 35)? '${listQuestionObject[index].question.values.toList()[0].toString().substring(0, 33)}...': listQuestionObject[index].question.values.toList()[0].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            ),  
                          )          
                        ],
                      ),
                    )));
              },  
            ),

            ),
            
             
          ],
      
        ),


        bottomSheet: Container(
         
          height: 60,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Center(
              child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) {
                
                  return   QuestionListDisplayPageWidget(flag_for_page, object, questionType);
                }),
              );
            },
            child: const Text(
              'ወደ ኋላ ተመለስ',
              style: TextStyle(color: Colors.white),
            ),
          )),
        ),
      ),
    );
  }
}



/*

 Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 1)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(builder: (ctx) {
                          //     return AdminLandingPageWidget();
                          //   }),
                          // );
                        },
                        child: const Text(
                          'DashBoard',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 2)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(builder: (ctx) {
                          //     return QuestionManagementLandingPage();
                          //   }),
                          // );
                        },
                        child: const Text(
                          'Manage Question',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 3)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {},
                        child: const Text(
                          'Manage Students',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )

 */