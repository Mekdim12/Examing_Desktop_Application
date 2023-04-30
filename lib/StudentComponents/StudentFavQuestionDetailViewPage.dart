import 'dart:io';

import 'package:diving_licence_traning_center_student/StudentComponents/StudentMainLandingPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/QuestionModel.dart';
import '../Models/StudentModels.dart';
import 'StudentFavQuestionsDisplayingPage.dart';


class StudentFavoriteDetailPageWidget extends StatefulWidget {
   StudentFavoriteDetailPageWidget(this.studentObject, this.questionObject);

   Student studentObject;
   Question questionObject;

  @override
  State<StudentFavoriteDetailPageWidget> createState() =>
      StudentFavoriteDetailPageState();
}

class StudentFavoriteDetailPageState extends State<StudentFavoriteDetailPageWidget> {
  bool is_CWD_file_located = false;
  String cwd = "";

  @override
  Widget build(BuildContext context) {
    Student object = widget.studentObject;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    Question currentQuestion = widget.questionObject;

    Hive.box('CurrenWorkingDirectory');
    if (Hive.box('CurrenWorkingDirectory').get('cwd') != null) {
      is_CWD_file_located = true;
      cwd = Hive.box('CurrenWorkingDirectory').get('cwd');
    } else {
      is_CWD_file_located = false;
    }

    int flag = widget.questionObject.exam_type;

    int choice = (currentQuestion.correct_answer == 'A')
        ? 1
        : (currentQuestion.correct_answer == 'B')
            ? 2
            : (currentQuestion.correct_answer == 'C')
                ? 3
                : 4;
    return Scaffold(
      body:  Container(
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
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black38),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentFavoriteFirstPageWidget(object);
                        }),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "ወደ ኋላ ተመለስ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
              
            ],
          ), 

          Container(
            color: const Color.fromARGB(255, 186, 198, 187).withOpacity(0.3),
            height: 750,
            margin: EdgeInsets.symmetric(
                horizontal:
                    ((MediaQuery.of(context).size.width * 16) / 100) / 2,
                vertical: ((MediaQuery.of(context).size.height * 8) / 100) / 2),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: (flag == 1)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.question_mark,
                                color: Color.fromARGB(137, 2, 1, 1),
                                size: 40,
                              ),
                              (flag == 2 &&
                                      currentQuestion.question.keys
                                              .toList()[0]
                                              .toInt() !=
                                          1)
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Image.file(
                                          fit: BoxFit.contain,
                                          width: 400,
                                          height: 250,
                                          File(
                                              "$cwd\\CopiedFileAssets\\${currentQuestion.question.values.toList()[0].toString()}")),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  33, 186, 198, 187)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      margin: const EdgeInsets.only(
                                          left: 2, top: 25),
                                      width: MediaQuery.of(context).size.width -
                                          ((MediaQuery.of(context).size.width *
                                                  16) /
                                              50),
                                      height: 250,
                                      child: Text(
                                        textAlign: TextAlign.justify,
                                        currentQuestion.question.values
                                            .toList()[0]
                                            .toString(),
                                        // 'Enter The Question on the first field and the answers with any order into the following order',
                                        style: const TextStyle(
                                            height: 2,
                                            color: Colors.black,
                                            fontFamily: 'openSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 115, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                (choice == 1)
                                    ? const Icon(
                                        Icons.thumb_up,
                                        color:  Color.fromARGB(255, 235, 187, 40),
                                      )
                                    : const Icon(
                                        Icons.thumb_down,
                                        color: Colors.red,
                                      ),
                                (flag == 2 &&
                                        currentQuestion.list_choice[0].keys
                                                .toList()[0]
                                                .toInt() !=
                                            1)
                                    ? Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 1) ? 2 : 1,
                                              color: (choice == 1)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        margin: EdgeInsets.only(left: 100),
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            fit: BoxFit.contain,
                                            width: 250,
                                            height: 150,
                                            File(
                                                "$cwd\\CopiedFileAssets\\${currentQuestion.list_choice[0].values.toList()[0].toString()}")),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width: 500,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 1) ? 2 : 1,
                                              color: (choice == 1)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            currentQuestion
                                                .list_choice[0].values
                                                .toList()[0]
                                                .toString() ,
                                            softWrap: true,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'quickSand',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                (choice == 3)
                                    ? const Icon(
                                        Icons.thumb_up,
                                        color: Color.fromARGB(255, 235, 187, 40),
                                      )
                                    : const Icon(
                                        Icons.thumb_down,
                                        color: Colors.red,
                                      ),
                                (flag == 2 &&
                                        currentQuestion.list_choice[2].keys
                                                .toList()[0]
                                                .toInt() !=
                                            1)
                                    ? Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 3) ? 2 : 1,
                                              color: (choice == 3)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        margin: EdgeInsets.only(left: 100),
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            fit: BoxFit.contain,
                                            width: 250,
                                            height: 150,
                                            File(
                                                "$cwd\\CopiedFileAssets\\${currentQuestion.list_choice[2].values.toList()[0].toString()}")),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width: 500,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 3) ? 2 : 1,
                                              color: (choice == 3)
                                                  ? Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            currentQuestion
                                                .list_choice[2].values
                                                .toList()[0]
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'quickSand',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                (choice == 2)
                                    ? const Icon(
                                        Icons.thumb_up,
                                        color:  Color.fromARGB(255, 235, 187, 40),
                                      )
                                    : const Icon(
                                        Icons.thumb_down,
                                        color: Colors.red,
                                      ),
                                (flag == 2 &&
                                        currentQuestion.list_choice[1].keys
                                                .toList()[0]
                                                .toInt() !=
                                            1)
                                    ? Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 2) ? 2 : 1,
                                              color: (choice == 2)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        margin:
                                            const EdgeInsets.only(left: 100),
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            fit: BoxFit.contain,
                                            width: 250,
                                            height: 150,
                                            File(
                                                "$cwd\\CopiedFileAssets\\${currentQuestion.list_choice[1].values.toList()[0].toString()}")),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width: 500,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 2) ? 2 : 1,
                                              color: (choice == 2)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            currentQuestion
                                                .list_choice[1].values
                                                .toList()[0]
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'quickSand',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 80),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                (choice == 4)
                                    ? const Icon(
                                        Icons.thumb_up,
                                        color: Color.fromARGB(255, 235, 187, 40),
                                      )
                                    : const Icon(
                                        Icons.thumb_down,
                                        color: Colors.red,
                                      ),
                                (flag == 2 &&
                                        currentQuestion.list_choice[3].keys
                                                .toList()[0]
                                                .toInt() !=
                                            1)
                                    ? Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 4) ? 2 : 1,
                                              color: (choice == 4)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        margin:
                                            const EdgeInsets.only(left: 100),
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            fit: BoxFit.contain,
                                            width: 250,
                                            height: 150,
                                            File(
                                                "$cwd\\CopiedFileAssets\\${currentQuestion.list_choice[3].values.toList()[0].toString()}")),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width: 500,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 4) ? 2 : 1,
                                              color: (choice == 4)
                                                  ?  Color.fromARGB(255, 81, 186, 135)
                                                  : Colors.red),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            currentQuestion
                                                .list_choice[3].values
                                                .toList()[0]
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'quickSand',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
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
    );
  }
}


