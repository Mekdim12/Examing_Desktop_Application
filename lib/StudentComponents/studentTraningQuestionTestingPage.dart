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
	int questionIndex; // for displaying the question and marking active on sidebar
    Student studentObject; // student info tracking
    String questionType; // 1-9 question type
    String flag_for_page; // menu identifier

  StudentQuestionTypeSpecificTestingPageWidget(this.studentObject, this.flag_for_page, this.questionType, this.questionIndex, {super.key});

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
             
              
            ],
          ),
        ),
      ),
    );
  }
}
