import 'package:flutter/material.dart';
import './adminTypeOfQuestionChossingPage.dart';
import '../Models/QuestionModel.dart';

class TextBasedQuestionInsertingPageWidget extends StatefulWidget {
  const TextBasedQuestionInsertingPageWidget({super.key});

  @override
  State<TextBasedQuestionInsertingPageWidget> createState() =>
      TextBasedQuestionInsertingPageState();
}

class TextBasedQuestionInsertingPageState
    extends State<TextBasedQuestionInsertingPageWidget> {
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: const Text("Success Full Operation"),
            elevation: 8,
            icon: const Icon(Icons.gpp_good),
            iconColor: Colors.greenAccent,
            // backgroundColor: Color.fromARGB(225, 241, 237, 237),
            contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 25, 57, 42),
                fontWeight: FontWeight.bold),
            content: Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: const Text(
                textAlign: TextAlign.center,
                "You Have Success-fully Inserted quesion to the Database",
              ),
            ),

            actions: [
              ElevatedButton.icon(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor: MaterialStatePropertyAll(Colors.black),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.greenAccent)),
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
  void question_saver_to_db(String question, String choice_a, String choice_b,
      String choice_c, String choice_d, String correctAnswer) {
    List answers = [choice_a, choice_b, choice_c, choice_d];
    final question_object = Question(1, question, answers, correctAnswer);

    final db = QuestionBox.getAllTheQuestions();
    Future<int> obj = db.add(question_object);
    // calling up the diaglog if successfull
    obj.then((value) => openDialog());
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
  String choice = 'A';

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
                                  child: DropdownButton(
                                    dropdownColor:
                                        Color.fromARGB(170, 105, 240, 175),
                                    isExpanded: true,
                                    iconEnabledColor: Colors.green,
                                    iconSize: 30,
                                    icon: Icon(Icons.menu_book),
                                    value: choice,
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
                                          style: TextStyle(
                                              fontFamily: 'quickSand',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: 'B',
                                        child: Text(
                                          'B',
                                          style: TextStyle(
                                              fontFamily: 'quickSand',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: 'C',
                                        child: Text(
                                          'C',
                                          style: TextStyle(
                                              fontFamily: 'quickSand',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: 'D',
                                        child: Text(
                                          'D',
                                          style: TextStyle(
                                              fontFamily: 'quickSand',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  question_saver_to_db(
                                      question_controller.text,
                                      choice_a_controller.text,
                                      choice_b_controller.text,
                                      choice_c_controller.text,
                                      choice_d_controller.text,
                                      choice);
                                  question_controller.clear();
                                  choice_a_controller.clear();
                                  choice_b_controller.clear();
                                  choice_c_controller.clear();
                                  choice_d_controller.clear();
                                  setState(() {
                                    choice = 'A';
                                  });
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
