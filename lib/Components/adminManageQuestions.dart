import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './adminQuestionManagementMenuPage.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import 'package:hive/hive.dart';

import './adminDetailForTextBased.dart';

class QuestionManagementPageWidget extends StatefulWidget {
  const QuestionManagementPageWidget({super.key});

  @override
  State<QuestionManagementPageWidget> createState() =>
      _QuestionManagementPageState();
}

class _QuestionManagementPageState extends State<QuestionManagementPageWidget> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      width: double.infinity,
      height: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              elevation: 5,
              toolbarOpacity: 0.2,
              bottom: const TabBar(
                indicatorColor: Colors.greenAccent,
                dividerColor: Colors.greenAccent,
                labelColor: Colors.greenAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                      text: "Text Based",
                      icon: Icon(
                        Icons.abc,
                        color: Colors.greenAccent,
                      )),
                  Tab(
                    iconMargin: EdgeInsets.all(5),
                    text: "Image Based",
                    icon: Icon(
                      Icons.image,
                      color: Colors.greenAccent,
                    ),
                  )
                ],
              ),
              foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
              backgroundColor: Color.fromARGB(255, 86, 85, 107),
              leadingWidth: 150,
              leading: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(164, 101, 100, 124)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) {
                        return QuestionManagementLandingPage();
                      }),
                    );
                  },
                  icon: const Icon(Icons.backspace_rounded),
                  label: const Text(
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.greenAccent),
                  ),
                ),
              ),
              title: const Text(
                'List Of Questsions Available',
                style: TextStyle(
                    color: Color.fromARGB(196, 105, 240, 175),
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: TabBarView(children: [
              Container(
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50),
                      child: const Text(
                        "List Of Text Based Questions",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Expanded(child: ListItemBuilderWidget(1)),
                  ],
                ),
              ),
              Container(
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50),
                      child: const Text(
                        "List Of Image Based Questions",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Expanded(child: ListItemBuilderWidget(2)),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}

class ListItemBuilderWidget extends StatefulWidget {
  final int flag;
  const ListItemBuilderWidget(this.flag, {super.key});

  @override
  State<ListItemBuilderWidget> createState() => _ListItemBuilderState();
}

class _ListItemBuilderState extends State<ListItemBuilderWidget> {
  bool isDeleteHover = false;
  bool isContainerHovered = false;
  bool isDeleteButtonPressed = false;
  int indexOfHovered = 0;
  List type_of_question = ['ሞተርሳይክል',
                          'አዉቶሞቢል',
                           'ታክሲ 1',
                          'ታክሲ 2',
                          'ደረቅ 1',
                          'ደረቅ 2', 
                          'ደረቅ 3',
                          'ህዝብ 1',
                          'ህዝብ 2'
                          ];
  String typeIdentifier(String currentQuestionkey){
   
    Box<QuestionTypeModel> dbs = QuestionTypeBox.getAllTheQuestionsTypes();
    dbs.toMap().forEach((key, value) {
        if (value.question_type_items.keys.toList()[0].toString() == currentQuestionkey){
              currentQuestionkey = type_of_question[int.parse(value.question_type_items.values.toList()[0].toString()) - 1].toString();
        }
    });
    return currentQuestionkey;
    
  }
 
  void SnackBarBuilderAndDisplay(BuildContext context, int index) {
    final snackBar = SnackBar(
      content: Container(
        height: 32,
        child: Center(
            child: Text(
          "You Have SucessFull Deleted",
          style: TextStyle(color: Colors.greenAccent),
        )),
      ),
      action: SnackBarAction(
        label: 'close',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<Question> listOfItemsDataBaseFetcher(int flag) {
    Box<Question> db = QuestionBox.getAllTheQuestions();
    List<Question> temporaryHolder = [];

    db.toMap().forEach((key, value) {
      if (value.exam_type == flag) {
        temporaryHolder.add(value);
      }
    });

    return temporaryHolder;
  }

  @override
  Widget build(BuildContext context) {
    int currentState = widget.flag;

    List<Question> value = listOfItemsDataBaseFetcher(currentState);
    
    if(value.length <=  0){
      return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    alignment: Alignment.center,
                    child: const Text(
                      "No Items Found In The Database",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'quickSand',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
    }else{
      if(value.isNotEmpty){
        if(value[0].question.isNotEmpty){

                  return ValueListenableBuilder(
      
        valueListenable: QuestionBox.getAllTheQuestions().listenable(),
        
        builder: (context, box, child) {
          return (value.length > 0)
              ? ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, int index) => InkWell(
                    onTap: () {
                      
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return DetailAdminWidget(
                              currentState, value[index].key);
                        }),
                      );
                    },
                    onHover: (val) {
                      indexOfHovered = index;
                      isContainerHovered = val;
                      setState(() {
                        isContainerHovered;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 80,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.greenAccent)),
                        borderOnForeground: true,
                        elevation: 8,
                        color: (isContainerHovered && indexOfHovered == index)
                            ? const Color.fromARGB(139, 255, 255, 255)
                            : const Color.fromARGB(115, 255, 255, 255),
                        margin: const EdgeInsets.symmetric(horizontal: 150),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text((index + 1).toString(),
                                      style: const TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      maxLines: 2,
                                      softWrap: true,
                                      
                                      value[index]
                                          .question
                                          .values.toList()[0].toString()
                                          ,
                                      style: const TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Type : ",
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontFamily: 'openSans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            textAlign: TextAlign.start,
                                            (currentState == 1)
                                                ? typeIdentifier(value[index].key.toString())
                                                : typeIdentifier(value[index].key.toString()),
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: 'openSans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        (isDeleteHover &&
                                                indexOfHovered == index)
                                            ? Colors.greenAccent
                                            : const Color.fromARGB(
                                                135, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () async{
                                      String cwd = Hive.box('CurrenWorkingDirectory').get('cwd').toString();

                                    if(value[index].exam_type != 1){
                                      if(value[index].question.keys.first != 1){
                                            File file_to_delete = File('${cwd}\\CopiedFileAssets\\${value[index].question.values.first}');
                                            if(await file_to_delete.exists()){
                                                  await file_to_delete.delete();
                                            }
                                      }

                                      for(var choice in value[index].list_choice){
                                          if(choice.keys.first != 1){
                                            File file_to_delete = File('${cwd}\\CopiedFileAssets\\${choice.values.first}');
                                            
                                            if(await file_to_delete.exists()){
                                                await file_to_delete.delete();
                                            }
                                          }
                                      }
                                    }

                                  Future.delayed(Duration(milliseconds: 100));
                                  
                                  Box<QuestionTypeModel> db = QuestionTypeBox.getAllTheQuestionsTypes();
                                  //   get the index the item
                                  int keyofQuestionType = -1100000;
                                  db.toMap().forEach((key, value_) { 
                                    if(value_.question_type_items.keys.toList()[0].toString()  == value[index].key.toString()){
                                      keyofQuestionType = key;   
                                    }
                                  });

                                  await db.delete(keyofQuestionType);

                                  Future.delayed(Duration(milliseconds: 100));
                                  
                                  await QuestionBox.getAllTheQuestions().delete(value[index].key);
                                  
                                  SnackBarBuilderAndDisplay(context, index);
                                     
                                    },
                                    onHover: (_) {
                                      setState(() {
                                        isDeleteHover = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const Text(''),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    alignment: Alignment.center,
                    child: const Text(
                      "No Items Found In The Database",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'quickSand',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
        });
  
        }else{
          return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    alignment: Alignment.center,
                    child: const Text(
                      "No Items Found In The Database",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'quickSand',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
        }
      }else{
        return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    alignment: Alignment.center,
                    child: const Text(
                      "No Items Found In The Database",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'quickSand',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
      }
    }
    
    
  
  
  }
}
