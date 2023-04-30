import 'package:flutter/material.dart';
import './adminTypeOfQuestionChossingPage.dart';
import '../Models/QuestionModel.dart';
import '../Models/QuestionTypeModel.dart';
import 'Admin_login_page.dart';
class TextBasedQuestionInsertingPageWidget extends StatefulWidget {
  const TextBasedQuestionInsertingPageWidget({super.key});

  @override
  State<TextBasedQuestionInsertingPageWidget> createState() =>
      TextBasedQuestionInsertingPageState();
}

String choice = 'A';
String type_choice = '1';
class TextBasedQuestionInsertingPageState
    extends State<TextBasedQuestionInsertingPageWidget> {
  Future openDialog(bool good_or_bad) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: (good_or_bad)
                ? const Text("Success-Full Operation")
                : const Text("Unsuccess-Full Operation"),
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
            iconColor: (good_or_bad) ? Colors.greenAccent : Colors.redAccent,
            // backgroundColor: Color.fromARGB(225, 241, 237, 237),
            contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 25, 57, 42),
                fontWeight: FontWeight.bold),
            content: Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Text(
                textAlign: TextAlign.center,
                (good_or_bad)
                    ? "You Have Success-fully Inserted quesion to the Database"
                    : "The Operation Failed and The Data You Entered Is Not Inserted On The Database",
              ),
            ),

            actions: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor: MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll((good_or_bad)
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
                  ))
            ],
          ));

  bool question_saver_to_db(String question, String choice_a, String choice_b,
      String choice_c, String choice_d, String correctAnswer, String question_type) {

       
    final question_object = Question(
        // 1 : implies that the text containe an text based question or answer[choice]
        1,
        {1: question},
        [
          {1: choice_a},
          {1: choice_b},
          {1: choice_c},
          {1: choice_d},
        ],
        correctAnswer);



    try {
      final db = QuestionBox.getAllTheQuestions();
      Future<int> obj = db.add(question_object);
      // calling up the diaglog if successfull
      obj.then((value){
        QuestionTypeModel question_type_object = QuestionTypeModel({value.toString(): type_choice.toString()});
        final db2 = QuestionTypeBox.getAllTheQuestionsTypes();
        Future<int> resp = db2.add(question_type_object);
        resp.then((value){
            openDialog(true);
        });
        
      });
      return true;
    } catch (Exception) {
      openDialog(false);
    }

    return false;
  }

  Widget choice_widget_builder(
      String labelText, TextEditingController controller_field) {
    return TextField(
      controller: controller_field,
      maxLines: 2,
      minLines: 1,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 2, color: Color.fromARGB(188, 105, 240, 175)),
            borderRadius: BorderRadius.circular(10)),
        icon: const Icon(Icons.question_answer),
        iconColor: const Color.fromARGB(255, 213, 207, 214),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.greenAccent),
      ),
      cursorColor: const Color.fromARGB(255, 227, 220, 228),
    );
  }

  final List<String> answersList = [
    'A',
    'B',
    'C',
    'D',
  ];
  // String choice = 'A';

  @override
  Widget build(BuildContext context) {
    final question_controller = TextEditingController();
    final choice_a_controller = TextEditingController();
    final choice_b_controller = TextEditingController();
    final choice_c_controller = TextEditingController();
    final choice_d_controller = TextEditingController();

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) {
                      return QuestionTypeChoosingPage();
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
            'Text Based Questions',
            style: TextStyle(
                color: Color.fromARGB(255, 217, 217, 225),
                fontWeight: FontWeight.bold),
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
                vertical: ((MediaQuery.of(context).size.height * 8) / 100) / 2),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            width: MediaQuery.of(context).size.width -
                                ((MediaQuery.of(context).size.width * 16) / 50),
                            // height: 30,
                            padding: const EdgeInsets.all(5),
                            color: const Color.fromARGB(33, 186, 198, 187)
                                .withOpacity(0.3),
                            child: const Text(
                              'Enter The Question on the first field and the answers with any order into the following order',
                              style: TextStyle(
                                height: 2,
                                color: Color.fromARGB(172, 105, 240, 175),
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      TextField(
                        controller: question_controller,
                        maxLines: 3,
                        minLines: 1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(10)),
                          icon: const Icon(Icons.question_mark_rounded),
                          iconColor: const Color.fromARGB(255, 213, 207, 214),
                          labelText: "Enter The Question Here ?",
                          labelStyle:
                              const TextStyle(color: Colors.greenAccent),
                        ),
                        cursorColor: const Color.fromARGB(255, 227, 220, 228),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80, left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder(
                                  'Enter choice A', choice_a_controller),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 80),
                          ),
                          Flexible(
                            child: Container(
                                width: 600,
                                child: choice_widget_builder(
                                    'Enter choice C', choice_c_controller)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder(
                                  'Enter choice B', choice_b_controller),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 80),
                          ),
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder(
                                  'Enter choice D', choice_d_controller),
                            ),
                          )
                        ],
                      ),
                      

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: const Text(
                                    'Select Type of question:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(169, 255, 255, 255)),
                                  ),
                                ),
                               
                                Container(
                                  margin:const EdgeInsets.symmetric(vertical: 25),
                                  child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(color: Colors.greenAccent)),
                                            alignment: Alignment.center,
                                            width: 290,
                                            margin: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: QuestionTypeChosserDropDownWidget(),
                                    ),
                                  ),
                             
                              ],
                            ),
                             ],
                        ),
                      ),
                          

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: const Text(
                                    'Select Correct Answer:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(169, 255, 255, 255)),
                                  ),
                                ),
                               
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.greenAccent)),
                                  alignment: Alignment.center,
                                  width: 120,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: DropDownButtonWidget(),
                                ),
                             
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              // margin: const EdgeInsets.only(left: 150),
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.save),
                                label: const Text("Save"),
                                style: ButtonStyle(
                                  elevation: MaterialStatePropertyAll(15),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(197, 76, 175, 79)),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                  ),
                                ),
                                onPressed: () {
                                  // print(choice);
                                  // print(type_choice);
                                  if (question_saver_to_db(
                                      question_controller.text,
                                      choice_a_controller.text,
                                      choice_b_controller.text,
                                      choice_c_controller.text,
                                      choice_d_controller.text,
                                      choice,
                                      type_choice)) {
                                    question_controller.clear();
                                    choice_a_controller.clear();
                                    choice_b_controller.clear();
                                    choice_c_controller.clear();
                                    choice_d_controller.clear();
                                    setState(() {
                                      choice = 'A';
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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
  }
}

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({super.key});

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Color.fromARGB(170, 105, 240, 175),
      isExpanded: true,
      iconEnabledColor: Colors.green,
      iconSize: 30,
      icon: const Icon(Icons.menu_book),
      value: choice.isEmpty? null: choice,
      onChanged: (val) {
        setState(() {
          choice = val!;
        });
      },
      items: const [
        DropdownMenuItem(
          alignment: Alignment.center,
          value: 'A',
          child: Text(
            'A',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: 'B',
          child: Text(
            'B',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: 'C',
          child: Text(
            'C',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: 'D',
          child: Text(
            'D',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}



class QuestionTypeChosserDropDownWidget  extends StatefulWidget {
  const QuestionTypeChosserDropDownWidget ({super.key});

  @override
  State<QuestionTypeChosserDropDownWidget > createState() => _QuestionTypeChosserDropDownState();
}

class _QuestionTypeChosserDropDownState  extends State<QuestionTypeChosserDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      
      // dropdownColor:const Color.fromARGB(170, 105, 240, 175),
      isExpanded: true,
      iconEnabledColor: Colors.green,
      iconSize: 30,
      icon: const Icon(Icons.menu_book),
      value: type_choice.isEmpty? null: type_choice,
      onChanged: (val) {
        setState(() {
          type_choice = val!;
        });
      },

      items: const [
         
      DropdownMenuItem(
          alignment: Alignment.center,
          value: '1',
          child: Text(
            'ሞተርሳይክል',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        

       DropdownMenuItem(
          alignment: Alignment.center,
          value: '2',
          child: Text(
            'አዉቶሞቢል',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '3',
          child: Text(
            'ታክሲ 1',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '4',
          child: Text(
            'ታክሲ 2',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '5',
          child: Text(
            'ደረቅ 1',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '6',
          child: Text(
            'ደረቅ 2',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '7',
          child: Text(
            'ደረቅ 3',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '8',
          child: Text(
            'ህዝብ 1',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          alignment: Alignment.center,
          value: '9',
          child: Text(
            'ህዝብ 2',
            style:
                TextStyle(fontFamily: 'quickSand', fontWeight: FontWeight.bold),
          ),
        ),


      ],
    );
  }
}











/*

ሞተርሳይክል
አዉቶሞቢል
ታክሲ 2
ታክሲ 1
ደረቅ 1
ደረቅ 2 
ደረቅ 3
ህዝብ 1
ህዝብ 2

 */