import 'package:flutter/material.dart';
import './adminTypeOfQuestionChossingPage.dart';

class TextBasedQuestionInsertingPageWidget extends StatefulWidget {
  const TextBasedQuestionInsertingPageWidget({super.key});

  @override
  State<TextBasedQuestionInsertingPageWidget> createState() =>
      TextBasedQuestionInsertingPageState();
}

class TextBasedQuestionInsertingPageState
    extends State<TextBasedQuestionInsertingPageWidget> {
  Widget choice_widget_builder(String labelText) {
    return TextField(
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
                              child: choice_widget_builder('Enter choice A'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 80),
                          ),
                          Flexible(
                            child: Container(
                                width: 600,
                                child: choice_widget_builder('Enter choice C')),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder('Enter choice B'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 80),
                          ),
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder('Enter choice D'),
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
                                onPressed: () {},
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
