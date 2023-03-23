import 'dart:io';

import 'package:flutter/material.dart';
import '../Models/QuestionModel.dart';
import 'package:hive/hive.dart';
import './adminManageQuestions.dart';

class DetailAdminWidget extends StatefulWidget {
  final int keyOfQuestionFromdatabase;
  final int flag;
  const DetailAdminWidget(this.flag, this.keyOfQuestionFromdatabase,
      {super.key});

  @override
  State<DetailAdminWidget> createState() => _DetailAdminWidgetState();
}

class _DetailAdminWidgetState extends State<DetailAdminWidget> {
  bool is_CWD_file_located = false;
  String cwd = "";
  @override
  Widget build(BuildContext context) {
    int keyIndex = widget.keyOfQuestionFromdatabase;
    int flag = widget.flag;

    
    Hive.box('CurrenWorkingDirectory');
    if (Hive.box('CurrenWorkingDirectory').get('cwd') != null) {
      is_CWD_file_located = true;
      cwd = Hive.box('CurrenWorkingDirectory').get('cwd');
    } else {
      is_CWD_file_located = false;
    }

    Box<Question> db = QuestionBox.getAllTheQuestions();
    Question currentQuestion = db.get(keyIndex)!;

    
    
    int choice = (currentQuestion.correct_answer == 'A')
        ? 1
        : (currentQuestion.correct_answer == 'B')
            ? 2
            : (currentQuestion.correct_answer == 'C')
                ? 3
                : 4;

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: const Color(0xFF65647C),
          title: Text(
            (flag == 1) ? 'Text Based Questions' : "Image Based Questions",
            style: const TextStyle(
                color: Color.fromARGB(255, 217, 217, 225),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                iconSize: 35,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundEntrance.jpg'),
            ),
          ),
          // ------------------------------------------------ Body ---------------------
          child: Container(
            color: const Color.fromARGB(255, 186, 198, 187).withOpacity(0.3),
            margin: EdgeInsets.symmetric(
                horizontal:
                    ((MediaQuery.of(context).size.width * 16) / 100) / 2,
                vertical: ((MediaQuery.of(context).size.height * 4) / 100) / 2),
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
                                color: Colors.white54,
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
                                      height: 130,
                                      child: Text(
                                        textAlign: TextAlign.justify,
                                        currentQuestion.question.values
                                            .toList()[0]
                                            .toString(),
                                        // 'Enter The Question on the first field and the answers with any order into the following order',
                                        style: const TextStyle(
                                            height: 2,
                                            color: Color.fromARGB(
                                                221, 105, 240, 175),
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
                  margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
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
                                        color: Colors.amber,
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
                                                  ? Colors.greenAccent
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
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 1) ? 2 : 1,
                                              color: (choice == 1)
                                                  ? Colors.greenAccent
                                                  : Colors.red),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            currentQuestion
                                                .list_choice[0].values
                                                .toList()[0]
                                                .toString(),
                                            softWrap: true,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.white60,
                                                fontFamily: 'quickSand',
                                                fontSize: 15,
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
                                        color: Colors.amber,
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
                                                  ? Colors.greenAccent
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
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 3) ? 2 : 1,
                                              color: (choice == 3)
                                                  ? Colors.greenAccent
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
                                                color: Colors.white60,
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
                                        color: Colors.amber,
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
                                                  ? Colors.greenAccent
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
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 2) ? 2 : 1,
                                              color: (choice == 2)
                                                  ? Colors.greenAccent
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
                                                color: Colors.white60,
                                                fontFamily: 'quickSand',
                                                fontSize: 15,
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
                                        color: Colors.amber,
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
                                                  ? Colors.greenAccent
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
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: (choice == 4) ? 2 : 1,
                                              color: (choice == 4)
                                                  ? Colors.greenAccent
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
                                                color: Colors.white60,
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
          ),
        ),
      ),
    );
    ;
  }
}
