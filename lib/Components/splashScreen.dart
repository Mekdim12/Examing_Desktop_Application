import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './privillageChoosingPage.dart';
import '../Models/QuestionModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/QuestionTypeModel.dart';


Future<List> heavyBackgroundTask(List infns )  async{

  
   List? TextbasedFinalHolder = [];
   List? ImageFinalHolder = [];
    // check for the export folder inside the cwd
    // if exists read everything inside image and text format in hive 
    // while reading image copy image into copied image file assets
    // when this done delete export folder

    Directory exported_file_path = Directory('${infns[0]}\\Export');
    List questionsList = infns[1];

   
    
    List? text_based_questions = [];
    List? image_based_question = [];
    List<Question>? text_based_qustions_resolved = [];
    List<Question>? image_based_qustions_resolved = [];
    List<QuestionTypeModel>? type_of_question_resolved = [];


    questionsList.forEach((element) {

        if(element['QuestionType'] == 1){
            text_based_questions.add(element);
        }else{
            image_based_question.add(element);
        }

    });
    
   
    //  first finish with the text base then u can replicate to the image based
    
    File exported_file_path_text_based_questions = File('${infns[0]}\\Export\\TextBasedQuestion.txt');
    if(await exported_file_path_text_based_questions.exists()){
         String file_content = await exported_file_path_text_based_questions.readAsString(encoding: utf8);
          
        if(file_content.toString().trim().isNotEmpty){

            if(file_content.toString().trim().startsWith('{') ){
                file_content = file_content.toString().trim().replaceFirst('{', '');
              }
              
              
            if(file_content.toString().trim().endsWith('}') ){
                file_content =  file_content.toString().trim().replaceRange(file_content.toString().trim().length -1, file_content.toString().trim().length,"");
            }
            
            // first seprate the question with <-#%~  so that u can get the individual question
            List available_questions = file_content.split('<-#%~');
            available_questions.asMap().forEach((key, value) {
                if(value.toString().trim().isNotEmpty){
                    List  question_items = value.toString().split("#%->")[1].split('…');

                    
                    int question_id= int.parse( question_items[0].toString().split('⳾->')[1].split('<-⳾')[0].toString().trim());
                    
                    String correct_answer = question_items[1].toString().split('꛴->')[1].split('<-꛴')[0].toString().trim();
                    
                    String question = question_items[2].toString().split('¿->')[1].split('<-¿')[0].toString();
                    int questionType = int.parse(question.split(':')[0].toString().trim());
                    String questionValue = question.split(':')[1].toString().trim();

                    List<Map<int,String>> choices = [];
                    List choice_splitted = question_items[3].toString().split('꘏->')[1].split('<-꘏')[0].toString().split('¶');
                    choice_splitted.forEach((element) { 
                        choices.add({int.parse(element.toString().split(':')[0].toString().trim()) : element.toString().split(':')[1].toString().trim()});
                    });

                    String questionType_on_options = question_items[4].toString().split('᥄->')[1].split('<-᥄')[0].toString().trim();
                    
                     
                    // now u have all the all information mapped sucessfully so check if the questions is already inside the database
                    bool flag = false;
                    text_based_questions.forEach((element) {
                         
                        if(element['Question'].toString().trim().split(':')[1].toString().trim().replaceRange(element['Question'].toString().trim().split(':')[1].toString().trim().length - 1 , element['Question'].toString().trim().split(':')[1].toString().trim().length, '').toString().trim() == questionValue){
                          // check the options 
                          if(element['List'].toString() == choices.toString()){
                            // check the correct answer
                            if(element['answer'].toString() == correct_answer.toString()){
                                  flag = true;                 
                            }
                          }
                          
                        }
                    });

                    if(! flag){
                     text_based_qustions_resolved.add(Question(1, {questionType:questionValue}, choices, correct_answer));
                 
                     TextbasedFinalHolder.add([Question(1, {questionType:questionValue}, choices, correct_answer), questionType_on_options]);
                    }

                }
            });
        }
           
    }

	
	

    
    
    File exported_file_path_image_based_questions = File('${infns[0]}\\Export\\ImageBasedQuestion.txt');
    if(await exported_file_path_image_based_questions.exists()){
         String file_content = await exported_file_path_image_based_questions.readAsString(encoding: utf8);
         
         if(file_content.toString().trim().isNotEmpty){

            if(file_content.toString().trim().startsWith('{') ){
                file_content = file_content.toString().trim().replaceFirst('{', '');
              }
              
              
            if(file_content.toString().trim().endsWith('}') ){
                file_content =  file_content.toString().trim().replaceRange(file_content.toString().trim().length -1, file_content.toString().trim().length,"");
            }

          
            // first seprate the question with <-#%~  so that u can get the individual question
            List available_questions = file_content.split('<-#%~');
            available_questions.asMap().forEach((key, value) {
                if(value.toString().trim().isNotEmpty){
                    List  question_items = value.toString().split("#%->")[1].split('…');
                    
                    int question_id= int.parse( question_items[0].toString().split('⳾->')[1].split('<-⳾')[0].toString().trim());
                    
                    String correct_answer = question_items[1].toString().split('꛴->')[1].split('<-꛴')[0].toString().trim();
                    
                    String question = question_items[2].toString().split('¿->')[1].split('<-¿')[0].toString();
                    int questionType = int.parse(question.split(':')[0].toString().trim());
                    String questionValue = question.split(':')[1].toString().trim();

                    List<Map<int,String>> choices = [];

                    List choice_splitted = question_items[3].toString().split('꘏->')[1].split('<-꘏')[0].toString().split('¶');

                    choice_splitted.forEach((element) { 
                        choices.add({int.parse(element.toString().split(':')[0].toString().trim()) : element.toString().split(':')[1].toString().trim()});
                    });

                    String questionType_on_options = question_items[4].toString().split('᥄->')[1].split('<-᥄')[0].toString().trim();

                    // now u have all the all information mapped sucessfully so check if the questions is already inside the database
                    bool flag = false;
                    
                    image_based_question.forEach((element) {
                    
                        if(element['Question'].toString().trim().split(':')[1].toString().trim().replaceRange(element['Question'].toString().trim().split(':')[1].toString().trim().length - 1 , element['Question'].toString().trim().split(':')[1].toString().trim().length, '').toString().trim() == questionValue){
                          // check the options 
                          if(element['List'].toString() == choices.toString()){
                            // check the correct answer
                            if(element['answer'].toString() == correct_answer.toString()){
                                  flag = true;          
                            }
                          }
                          
                        }
                    });


                    if(! flag){
                      
                        ImageFinalHolder.add([Question(2, {questionType:questionValue}, choices, correct_answer), questionType_on_options]);
                        image_based_qustions_resolved.add(Question(2, {questionType:questionValue}, choices, correct_answer));
                    }
  
                  
                }
            });
        }
    }
    
    
   
    // now u can handle copying the image before setting to the database the text and save it to hive
    List<Question>? image_based_qustions_resolved_  = [];
    for(var element in image_based_qustions_resolved){
        try{
        
          if(element.question.keys.first != 1){
            File image_to_copy_temp = File('${infns[0]}\\Export\\Images\\${element.question.values.first}');
            if(await image_to_copy_temp.exists()){
              // check if same file exists if exist just ignores it if its is no there copy it 
                if(! await File('${infns[0]}\\CopiedFileAssets\\${element.question.values.first}').exists()){
                   await  image_to_copy_temp.copy('${infns[0]}\\CopiedFileAssets\\${element.question.values.first}');
                }

            }else{
               throw Exception;
            }
          }

          for(var choice in element.list_choice){
            if(choice.keys.first != 1){
              File image_to_copy_temp = File('${infns[0]}\\Export\\Images\\${choice.values.first}');
              if(await image_to_copy_temp.exists()){
                  if(! await File('${infns[0]}\\CopiedFileAssets\\${choice.values.first}').exists()){
                   await  image_to_copy_temp.copy('${infns[0]}\\CopiedFileAssets\\${choice.values.first}');
                  }
              }else{
                 throw Exception;
                 
              }
            }
          }
          
          image_based_qustions_resolved_.add(element);
        }catch(Exception){
          return [];
        }
      }

    
    //   now loop throught those lists resolved on and write it on hive db so returning will be ideal since u can't perform hive operation here
    
     return [TextbasedFinalHolder, ImageFinalHolder];

  
}

class splashScreen extends StatelessWidget {
   const splashScreen({Key? key}) : super(key: key);
  
 
  Future<bool> compute_methodCallerSimpleFunction(List values) async {
    
    if (values.toList().length  <= 0){
      return true;
    }
    String CWD = values[0];

    if (CWD != null) {

      Directory exportPath = Directory('$CWD\\Export');
      List<Map<String, Object>> questionList = values[1];

      
      if(await exportPath.exists()){
        try{
        
            List resolvedListOfQuestionData =  await compute(heavyBackgroundTask, [CWD, questionList]);

                if(resolvedListOfQuestionData.length > 0){

                  if(resolvedListOfQuestionData[0] != null &&  resolvedListOfQuestionData[0].length > 0){
                      
                          List? textBasedQuestionData = resolvedListOfQuestionData[0];
                          
                          Box<Question> db = QuestionBox.getAllTheQuestions();
                          Box<QuestionTypeModel> db2 = QuestionTypeBox.getAllTheQuestionsTypes();
                      
                      for(var data in resolvedListOfQuestionData[0]){
                        int keyQuestionObjectStoredIn = await db.add(data[0]);
                        await db2.add(QuestionTypeModel({keyQuestionObjectStoredIn.toString(): data[1]}));
                      }

					  if(resolvedListOfQuestionData[1] != null &&  resolvedListOfQuestionData[1].length > 0){
                      List? imageBasedQuestionData = resolvedListOfQuestionData[1];
					  Box<Question> db = QuestionBox.getAllTheQuestions();
                      Box<QuestionTypeModel> db2 = QuestionTypeBox.getAllTheQuestionsTypes();

					  for(var data in resolvedListOfQuestionData[1]){
                        int keyQuestionObjectStoredIn = await db.add(data[0]);
                        await db2.add(QuestionTypeModel({keyQuestionObjectStoredIn.toString(): data[1]}));
                      }
                
					}
         
                    }

					// if all goes right , there is no points keeping these file so delete export folder
					await exportPath.delete(recursive: true);
                  
            }

        }catch(Exception ){}
       
      } 
    }

    await Future.delayed(Duration(seconds: 4));
    return true;
  }

  List  prepareDataForProcess(){
     Box<Question> db = QuestionBox.getAllTheQuestions();
     List<Map<String, Object>> temporaryQuestionHolder = [];
  try{
    String CWD = Hive.box('CurrenWorkingDirectory').get('cwd') ;
          
      

     db.toMap().forEach((key, value) {
          temporaryQuestionHolder.add( {
              'QuestionType': value.exam_type,
              'Question':value.question,
              'List':value.list_choice,
              'answer':value.correct_answer
          });

      });
    

    
    return [CWD, temporaryQuestionHolder,db];
      }catch(Exception){
        return [];
      }
  }

  @override
  Widget build(BuildContext context)  {
    
    bool is_CWD_file_located = false;

    // print(prepareDataForProcess());
    Future<bool> flag = compute_methodCallerSimpleFunction(prepareDataForProcess());

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
