import 'dart:convert';
import 'dart:io';
import 'package:async_foreach/async_foreach.dart';
import 'package:diving_licence_traning_center_student/Models/QuestionModel.dart';
import 'package:flutter/material.dart';
import './adminQuestionManagementMenuPage.dart';
import './adminTextBasedQuestionInsertingPage.dart';
import './adminImageBasedQuestionInsertingPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/QuestionTypeModel.dart';

class QuestionTypeChoosingPage extends StatefulWidget {
  const QuestionTypeChoosingPage({super.key});

  @override
  State<QuestionTypeChoosingPage> createState() =>
      _QuestionTypeChoosingPageState();
}

class _QuestionTypeChoosingPageState extends State<QuestionTypeChoosingPage> {
  bool isExportingButtonPressed = false;
  String exportButtonBefore = "Export Question For Sharing";

  Future openDialog(
          bool good_or_bad, String messageHeader, String messageBody) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                buttonPadding: const EdgeInsets.all(5),
                contentPadding: const EdgeInsets.all(15),
                title: Text(messageHeader),
                elevation: 8,
                icon: (good_or_bad)
                    ? const Icon(
                        Icons.gpp_good,
                        weight: 50,
                        size: 50,
                      )
                    : const Icon(
                        Icons.gpp_bad,
                        weight: 50,
                        size: 50,
                      ),
                iconColor:
                    (good_or_bad) ? Colors.greenAccent : Colors.redAccent,
                // backgroundColor: Color.fromARGB(225, 241, 237, 237),
                contentTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 25, 57, 42),
                    fontWeight: FontWeight.bold),
                content: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Text(
                    textAlign: TextAlign.center,
                    messageBody,
                  ),
                ),

                actions: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20)),
                          iconColor: MaterialStatePropertyAll(Colors.black),
                          backgroundColor: MaterialStatePropertyAll(
                              (good_or_bad)
                                  ? Colors.greenAccent
                                  : Colors.redAccent)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(
                        "Close",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ],
              ));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: const Color(0xFF65647C),
          leadingWidth: 150,
          leading: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(164, 101, 100, 124)),
                ),
                onPressed: (isExportingButtonPressed)
                    ? null
                    : () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) {
                            return QuestionManagementLandingPage();
                          }),
                        );
                      },
                icon: const Icon(Icons.backspace_rounded),
                label: const Text(
                  "Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ),
          title: const Text(
            'Question Inserting Type',
            style: TextStyle(
                color: Color.fromARGB(255, 217, 217, 225),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundEntrance.jpg'),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(50, 20),
                        blurRadius: 10,
                      ),
                    ],
                    color: Color.fromARGB(199, 255, 255, 255),
                    fontFamily: 'openSans',
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.abc),
                        label: const Text("Insert Text Based Questions"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(188, 76, 175, 79)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 130, vertical: 25))),
                        onPressed: (isExportingButtonPressed)
                            ? null
                            : () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) {
                                  return TextBasedQuestionInsertingPageWidget();
                                }));
                              },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text("Insert Image Based Questions"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(188, 76, 175, 79)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 122, vertical: 25))),
                        onPressed: (isExportingButtonPressed)
                            ? null
                            : () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) {
                                  return ImageBasedQuesionInsertingPageWidget();
                                }));
                              },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.import_export),
                        label: Text(exportButtonBefore),
                        style: ButtonStyle(
                            side: MaterialStatePropertyAll(BorderSide(
                                color: (isExportingButtonPressed)
                                    ? Colors.blueAccent
                                    : Colors.green)),
                            backgroundColor: MaterialStateProperty.all(
                                (isExportingButtonPressed)
                                    ? Color.fromARGB(255, 71, 86, 72)
                                    : const Color.fromARGB(207, 71, 86, 72)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 122, vertical: 25))),
                        onPressed: (isExportingButtonPressed)
                            ? () {
                                openDialog(
                                    false,
                                    "Exporting Is Already Processing",
                                    "There is a process of exporting the data to sharable format so please do not close the app if u do may required to uninstall the software , but wait till this process finishes once it finished it will allow all the tasks");
                              }
                            : () {
                                isExportingButtonPressed =
                                    true; // change this later to True
                                setState(() {
                                  isExportingButtonPressed;
                                  exportButtonBefore = "  Exporting ... ";
                                });

                                ExportingFiles()
                                    .startExporting()
                                    .then((value) async {
                                  await Future.delayed(Duration(seconds: 10));
                                  // do ur task when its complete
                                  setState(() {
                                    isExportingButtonPressed = false;
                                    exportButtonBefore =
                                        "Export Question For Sharing";
                                  });
                                });
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// first check if already exported data is there then if there is one delete it
// then create appropriate path
// Export--Images--images.jpeg
//       --textbase.txt
//       --imagebase.txt

// if successfull create these structure --- Done Till this step

// now first copy all the files from the box to json format and when u working with image base copy the files to images folder too

// after finishing this task only left to clean
// so - delete the box [questionBox only]
//    - delte the copiedFileAssets
// then set isExportingButtonPressed = True and some scuess dialog

class ExportingFiles {
  List _textBasedQuestionHolder = [];
  List _imageBasedQuestinHolder = [];

  Future<dynamic> fileWriter(String cwd, String filename, int flag) async {

    
    File jsonWriter = File('$cwd\\Export\\$filename.txt');
    IOSink writer = jsonWriter.openWrite(mode: FileMode.append);

   

    late List currentList;
    if (flag == 1) {
      //
      currentList = _textBasedQuestionHolder;
    } else {
      //
      currentList = _imageBasedQuestinHolder;
    }



    // var last_Object = currentList.removeLast();
    // last_Object = last_Object
    //     .toString()
    //     .replaceFirst(',', '', last_Object.toString().length - 2);

    // currentList.insert(currentList.length, last_Object);
    writer.writeAll(currentList);

    await writer.flush();
    return writer.close();
  }

  Future<String> stringNameExtracterFromTheMapAndCopier(Map<int, String> item, String cwd) async{
   
    var key = item.keys.toList()[0];
    var value = item.values.toList()[0];
    
   

   
    String for_ret = '';
    try {
      File fromCopiedFileAsser = File('$cwd\\CopiedFileAssets\\$value');
      var val = await fromCopiedFileAsser.copy('$cwd\\Export\\Images\\$value');
      for_ret = value;
      
      
    } catch (FileSystemException) {
      if (int.parse(FileSystemException.toString()
              .substring(FileSystemException.toString().lastIndexOf("=") + 1,
                  FileSystemException.toString().length - 1)
              .trim()) ==
          183) {
        for_ret =  value;
      }else{
        for_ret = '404';
      }
     
    }

    return for_ret;
  }

  Future<bool> checkerIfItemisImageOrNot(Map quesion, String cwd) async {
    bool result = false;
    if (quesion.keys.toList()[0].toString() == '2') {
      
      var imageName = quesion.values.toList()[0].toString();

      // a name from database so if there is name same as this in copied file asset then copy the file to export file folder
      File copiedFileAsset = File('$cwd\\CopiedFileAssets\\$imageName');

      result =  await copiedFileAsset.exists();
    }

   return result;
  }





Future<dynamic> imageTypeQuestionTypeHandler(String cwd, Question questionObject) async {
  

    Map<int, String> question = questionObject.question;
    var listOfChoice = questionObject.list_choice;
    bool any_failer = false;

    late Map questionFinalHolder;

    List choiceHolder = [];
    var ret_temp;

    // handling if question is image or not not the choices
    var value =  await checkerIfItemisImageOrNot(question, cwd);

    
    if (value) {
        
       var tempQuestionFinalHolder =  stringNameExtracterFromTheMapAndCopier(question, cwd);
      if (tempQuestionFinalHolder == '404') {
        any_failer = true;
      } else {
        questionFinalHolder = {
          question.keys.toList()[0]: question.values.toList()[0]
        };
      }
   
    } else {
      questionFinalHolder = {
        question.keys.toList()[0]: question.values.toList()[0]
      };
    }
  

    await listOfChoice.asyncForEach((element) async{
    
      var value = await checkerIfItemisImageOrNot(element, cwd);
    
          if (value) {

            var currentChoiceValue =  await stringNameExtracterFromTheMapAndCopier(element, cwd);
          
            if (currentChoiceValue == '404') {
              any_failer = true;
            } else {
              choiceHolder.add(
                  {element.keys.toList()[0].toString(): currentChoiceValue});
            }
           
          } else {
            choiceHolder.add({
              element.keys.toList()[0].toString():
                  element.values.toList()[0].toString()
            }); 
          }
          
      });

     
        if (!any_failer) {
              ret_temp =  {
              '\"${questionObject.key.toString()}\"': {
                '\"Type\"': '\"${questionObject.exam_type.toString()}\"',
                '\"CorretAnswer\"':
                    '\"${questionObject.correct_answer.toString()}\"',
                '\"Question\"': '{\"${questionFinalHolder.keys.first}\" : \"${questionFinalHolder.values.first} \"}',
                '\"Choices\"': [
                  {
                    '\"${choiceHolder[0].keys.toList()[0]}\"':
                        '\"${choiceHolder[0][choiceHolder[0].keys.toList()[0]]}\"'
                  },
                  {
                    '\"${choiceHolder[1].keys.toList()[0]}\"':
                        '\"${choiceHolder[1][choiceHolder[1].keys.toList()[0]]}\"'
                  },
                  {
                    '\"${choiceHolder[2].keys.toList()[0]}\"':
                        '\"${choiceHolder[2][choiceHolder[2].keys.toList()[0]]}\"'
                  },
                  {
                    '\"${choiceHolder[3].keys.toList()[0]}\"':
                        '\"${choiceHolder[3][choiceHolder[3].keys.toList()[0]]}\"'
                  },
                ],
              }
            };
           
    }

    var question_type = null;
    final db = QuestionTypeBox.getAllTheQuestionsTypes();
  
    db.toMap().forEach((key, value) {
          if(value.question_type_items.keys.toList()[0].toString() == questionObject.key.toString()){
              question_type = value.question_type_items.values.toList()[0].toString();
          }
      });  
    
    var temp2= "#%-> ⳾->${questionObject.key.toString()}<-⳾…꛴->${questionObject.correct_answer.toString()}<-꛴…¿->${questionObject.question.keys.first} : ${questionObject.question.values.first}<-¿…꘏->${questionObject.list_choice[0].keys.toList()[0]}:${questionObject.list_choice[0][questionObject.list_choice[0].keys.toList()[0]]}¶ ${questionObject.list_choice[1].keys.toList()[0]}:${questionObject.list_choice[1][questionObject.list_choice[1].keys.toList()[0]]}¶${questionObject.list_choice[2].keys.toList()[0]}:${questionObject.list_choice[2][questionObject.list_choice[2].keys.toList()[0]]}¶${questionObject.list_choice[3].keys.toList()[0]}:${questionObject.list_choice[3][questionObject.list_choice[3].keys.toList()[0]]}<-꘏…᥄->${question_type}<-᥄<-#%~ \n";
    
    return temp2;
  }

  String textTypeQuestionHandler(

      Question questionObject) {
    var temp = {
      '\"${questionObject.key.toString()}\"': {
        '\"Type\"': '\"${questionObject.exam_type.toString()}\"',
        '\"CorretAnswer\"': '\"${questionObject.correct_answer.toString()}\"',
        '\"Question\"': '{\"${questionObject.question.keys.first}\" : \"${questionObject.question.values.first} \"}',
        '\"Choices\"': [
          {
            '\"${questionObject.list_choice[0].keys.toList()[0]}\"':
                '\"${questionObject.list_choice[0][questionObject.list_choice[0].keys.toList()[0]]}\"'
          },
          {
            '\"${questionObject.list_choice[1].keys.toList()[0]}\"':
                '\"${questionObject.list_choice[1][questionObject.list_choice[1].keys.toList()[0]]}\"'
          },
          {
            '\"${questionObject.list_choice[2].keys.toList()[0]}\"':
                '\"${questionObject.list_choice[2][questionObject.list_choice[2].keys.toList()[0]]}\"'
          },
          {
            '\"${questionObject.list_choice[3].keys.toList()[0]}\"':
                '\"${questionObject.list_choice[3][questionObject.list_choice[3].keys.toList()[0]]}\"'
          }
        ]
      }
    };
    var question_type = null;
      final db = QuestionTypeBox.getAllTheQuestionsTypes();
      db.toMap().forEach((key, value) {
          if(value.question_type_items.keys.toList()[0].toString() == questionObject.key.toString()){
              question_type = value.question_type_items.values.toList()[0].toString();
          }
      });
     
      var temp2= "#%-> ⳾->${questionObject.key.toString()}<-⳾…꛴->${questionObject.correct_answer.toString()}<-꛴…¿->${questionObject.question.keys.first} : ${questionObject.question.values.first}<-¿…꘏->${questionObject.list_choice[0].keys.toList()[0]}:${questionObject.list_choice[0][questionObject.list_choice[0].keys.toList()[0]]}¶ ${questionObject.list_choice[1].keys.toList()[0]}:${questionObject.list_choice[1][questionObject.list_choice[1].keys.toList()[0]]}¶${questionObject.list_choice[2].keys.toList()[0]}:${questionObject.list_choice[2][questionObject.list_choice[2].keys.toList()[0]]}¶${questionObject.list_choice[3].keys.toList()[0]}:${questionObject.list_choice[3][questionObject.list_choice[3].keys.toList()[0]]}<-꘏…᥄->${question_type}<-᥄<-#%~ \n";
      return temp2;
  }

  Future<dynamic> jsonLastAndBraceAdder(
      String cwd, int pos, String fileName) async {
    File file = File('$cwd\\Export\\$fileName.txt');

    var ioSink = file.openWrite(mode: FileMode.append);

    if (pos == -1) {
      ioSink.write('\n}');
    } else {
      ioSink.writeln('{\n');
    }

    await ioSink.flush();
    return ioSink.close();
  }

  Future<bool> dataCopyHandler(String cwd) async{
   
    final db = QuestionBox.getAllTheQuestions();
    
    bool flag = false;
    if (db.isNotEmpty && db.isOpen) {
      await  jsonLastAndBraceAdder(cwd, 0, 'TextBasedQuestion');
      await jsonLastAndBraceAdder(cwd, 0, 'ImageBasedQuestion');

        for(var value in db.toMap().values){
              if(value.exam_type == 1){
            
                  String tempHolder =  textTypeQuestionHandler(value).toString();
                  
                  _textBasedQuestionHolder.add(tempHolder);
                  
            }else{
                 
                var tempHolder =
                  await imageTypeQuestionTypeHandler(cwd, value);

                tempHolder = tempHolder.toString();
                _imageBasedQuestinHolder.add(tempHolder);


            }
           
        }
        
        
        
        await fileWriter(cwd, 'TextBasedQuestion', 1);
        await  fileWriter(cwd, 'ImageBasedQuestion', 2);
        await jsonLastAndBraceAdder(cwd, -1, 'TextBasedQuestion');
        await   jsonLastAndBraceAdder(cwd, -1, 'ImageBasedQuestion');

        flag = true;
      
    }

    return flag;
  }

  Future<File> _fileCreater(String cwd, String fileName) {
    File file = File('$cwd\\Export\\$fileName.txt');
    return file.create();
  }

  Future<Directory> _folderCreater(Directory dir) {
    return dir.create();
  }

  Future<FileSystemEntity> _folderDeleter(Directory dir) {
    return dir.delete(recursive: true);
  }

  Future<bool> startExporting() async {


    var get_cwd_from_box = Hive.box('CurrenWorkingDirectory').get('cwd');


    if (get_cwd_from_box != null) {
      Directory cwd = Directory('$get_cwd_from_box\\Export');
      Directory cwd_image = Directory('$get_cwd_from_box\\Export\\Images');
      Future<Directory> futureHolderForExportFolder;
      Future<Directory> futureHolderForImagesFolder;

      bool messing_with_promise = false;

      if (await cwd.exists()) {
        if (await cwd_image.exists()) {
          await _folderDeleter(cwd_image);
          await _folderDeleter(cwd);

          try{
                await _folderCreater(cwd);
                await _folderCreater(cwd_image);
                await  _fileCreater(get_cwd_from_box, "TextBasedQuestion");
                await _fileCreater(get_cwd_from_box, "ImageBasedQuestion");

                return dataCopyHandler(get_cwd_from_box);


          }catch(Exception ){
            return false;
          }
             
        
        }
      } else {

        
          try{
                await _folderCreater(cwd);
                await _folderCreater(cwd_image);
                await  _fileCreater(get_cwd_from_box, "TextBasedQuestion");
                await _fileCreater(get_cwd_from_box, "ImageBasedQuestion");
                return dataCopyHandler(get_cwd_from_box);

          }catch(Exception ){
            return false;
          }


        // try {
        //   _folderCreater(cwd).then((value) {
        //     _folderCreater(cwd_image).then((value) {
        //       _fileCreater(get_cwd_from_box, "TextBasedQuestion").then((value) {
        //         _fileCreater(get_cwd_from_box, "ImageBasedQuestion")
        //             .then((value) {
        //           return dataCopyHandler(get_cwd_from_box);
        //         });
        //       });
        //     });
        //   });
        // } catch (Exception) {
        //   return false;
        // }
      }
    }

    return false;
  }
}
