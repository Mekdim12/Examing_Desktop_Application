import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './privillageChoosingPage.dart';
import '../Models/QuestionModel.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';




void heavyBackgroundTask(List infns )  async{

  
    // check for the export folder inside the cwd
    // if exists read everything inside image and text format in hive 
    // while reading image copy image into copied image file assets
    // when this done delete export folder

    Directory exported_file_path = Directory('${infns[0]}\\Export');
    List questionsList = infns[1];
    
   
     
  
}

class splashScreen extends StatelessWidget {
   const splashScreen({Key? key}) : super(key: key);
  

  Future<bool> compute_methodCallerSimpleFunction(List values) async {

    String CWD = values[0];

    if (CWD != null) {

      Directory exportPath = Directory('$CWD\\Export');
     List<Map<String, Object>> questionList = values[1];

      
      if(await exportPath.exists()){
         await compute(heavyBackgroundTask, [CWD, questionList]);
      } 

    }

    await Future.delayed(Duration(seconds: 4));
    return true;
  }

  List  prepareDataForProcess(){
     Box<Question> db = QuestionBox.getAllTheQuestions();
     List<Map<String, Object>> temporaryQuestionHolder = [];
     String CWD = Hive.box('CurrenWorkingDirectory').get('cwd') ;
      
      db.toMap().forEach((key, value) {

          temporaryQuestionHolder.add( {
              'QuestionType': value.exam_type,
              'Question':value.question,
              'List':value.list_choice,
              'answer':value.correct_answer
          });
      });
    
    return [CWD, temporaryQuestionHolder, db];
  }

  @override
  Widget build(BuildContext context)  {
    
    bool is_CWD_file_located = false;

    Future<bool> flag = compute_methodCallerSimpleFunction( prepareDataForProcess());

    flag.then((value) => {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) {
              return PrivillageChossingPage();
            }),
          )
        });

    return Container(
      constraints: const BoxConstraints.expand(),
      width: double.infinity,
      // height: double.infinity,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/backgroundEntrance.jpg'),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Car Driving Licence Traning Center",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 65,
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              height: 3,
              wordSpacing: 2,
              shadows: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 80)),
          // CircularProgressIndicator(),
          const SpinKitWave(
            color: Color.fromARGB(255, 176, 160, 160),
            size: 100.0,
          ),
        ],
      ),
    );
  }
}
