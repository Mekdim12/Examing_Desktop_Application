import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './adminTypeOfQuestionChossingPage.dart';
import '../Models/QuestionModel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageBasedQuesionInsertingPageWidget extends StatefulWidget {
  const ImageBasedQuesionInsertingPageWidget({super.key});

  @override
  State<ImageBasedQuesionInsertingPageWidget> createState() =>
      _ImageBasedQuesionInsertingPageState();
}

String choice = 'A';

class _ImageBasedQuesionInsertingPageState
    extends State<ImageBasedQuesionInsertingPageWidget> {
  final question_controller = TextEditingController();
  final choice_a_controller = TextEditingController();
  final choice_b_controller = TextEditingController();
  final choice_c_controller = TextEditingController();
  final choice_d_controller = TextEditingController();

  bool is_question_an_image = false;
  String question_text = "Enter The Question Here ?";
  String absolute_path_question = "";
  bool is_choice_a_an_image = false;
  String choice_a_text = 'Enter choice A';
  String absolute_path_a = "";
  bool is_choice_b_an_image = false;
  String choice_b_text = 'Enter choice B';
  String absolute_path_b = "";
  bool is_choice_c_an_image = false;
  String choice_c_text = 'Enter choice C';
  String absolute_path_c = "";
  bool is_choice_d_an_image = false;
  String choice_d_text = 'Enter choice D';
  String absolute_path_d = "";

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

  Map<int, String> item_to_put_into_db_formmater(questionAndAns_data) {
    int randomNumberGenerated = Random().nextInt(1000000000);

    File imageFile = File(questionAndAns_data.values
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', ''));

    String filename =
        "${imageFile.uri.pathSegments.last.split('.')[0]}$randomNumberGenerated";
    String filextension = imageFile.uri.pathSegments.last.split('.')[1];

    String fullName = "$filename.$filextension";
    String get_cwd_from_box = Hive.box('CurrenWorkingDirectory').get('cwd');

    if (get_cwd_from_box != null) {
      Directory cwd = Directory('$get_cwd_from_box/CopiedFileAssets');

      cwd.exists().then((value) {
        if (value) {
          try {
            imageFile
                .copy('$get_cwd_from_box/CopiedFileAssets/$fullName')
                .then((value) {
              return {2: fullName};
            });
          } catch (Exception) {
            return {};
          }
        } else {
          cwd.create().then((value) {
            try {
              imageFile
                  .copy('$get_cwd_from_box/CopiedFileAssets/$fullName')
                  .then((value) {
                return {2: fullName};
              });
            } catch (Exception) {
              return {};
            }
          });
        }
      });
    }

    return {};
  }

  bool question_saver_to_db(List questionAndAns_data, String correctAnswer) {
    List temp_choice_holder = [];
    Map temp_question = new Map<int, String>();

    try {
      for (int index = 0; index < questionAndAns_data.length; index++) {
        if (index == 4) {
          // the text question text or data
          if (questionAndAns_data[index].containsKey(2)) {
            temp_question =
                item_to_put_into_db_formmater(questionAndAns_data[index]);
          } else {
            temp_question = questionAndAns_data[index];
          }
        } else {
          if (questionAndAns_data[index].containsKey(2)) {
            // its image
            temp_choice_holder
                .add(item_to_put_into_db_formmater(questionAndAns_data[index]));
          } else {
            temp_choice_holder.add(questionAndAns_data[index]);
          }
        }
      }
    } catch (Exception) {
      openDialog(false);
    }

    Question question_object = Question(
      // 1 : implies that the text containe an text based question or answer[choice]
      // 2 : implies that the image containe an image based question or answer[choice]
      2,
      temp_question.cast(),
      temp_choice_holder.cast(),
      correctAnswer,
    );

    try {
      final db = QuestionBox.getAllTheQuestions();

      Future<int> obj = db.add(question_object);

      // calling up the diaglog if successfull

      obj.then((value) {
        openDialog(true);
        setState(() {
          is_question_an_image = false;
          question_text = "Enter The Question Here ?";
          absolute_path_question = "";
          is_choice_a_an_image = false;
          choice_a_text = 'Enter choice A';
          absolute_path_a = "";
          is_choice_b_an_image = false;
          choice_b_text = 'Enter choice B';
          absolute_path_b = "";
          is_choice_c_an_image = false;
          choice_c_text = 'Enter choice C';
          absolute_path_c = "";
          is_choice_d_an_image = false;
          choice_d_text = 'Enter choice D';
          absolute_path_d = "";
        });
      });
      return true;
    } catch (Exception) {
      openDialog(false);
    }

    return false;
  }

  Widget choice_widget_builder(String labelText,
      TextEditingController controller_field, bool enable_checker) {
    return TextField(
      enabled: !enable_checker,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
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
                      const Color.fromARGB(164, 101, 100, 124)),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) {
                      return const QuestionTypeChoosingPage();
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
            'Image Containing Questions',
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
                              'Enter The Question or Switch to Uploading Images Using Arrow button on the first field and the answers with any order into the following order',
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
                        margin: const EdgeInsets.symmetric(vertical: 25),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 25)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(172, 105, 240, 175))),
                              onPressed: (is_question_an_image)
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        dialogTitle:
                                            'Question and Answer Image picking ',
                                      );

                                      if (result != null) {
                                        absolute_path_question =
                                            result.files.single.path as String;
                                        setState(() {
                                          question_text =
                                              result.files.single.name;
                                        });
                                      } else {
                                        // nothing reall Got Picked
                                      }
                                    }
                                  : null,
                              icon: const Icon(Icons.attach_file),
                              label: const Text("Upload Image")),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                if (is_question_an_image) {
                                  is_question_an_image = false;
                                  question_text = "Enter The Question Here ?";
                                } else {
                                  is_question_an_image = true;
                                }
                                setState(() {
                                  is_question_an_image;
                                  question_text;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows,
                                  color: Colors.greenAccent, size: 35),
                              label: const Text(''),
                            ),
                          ),
                          Container(
                            width: 800,
                            child: TextField(
                              enabled: !is_question_an_image,
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
                                labelText: question_text,
                                labelStyle:
                                    const TextStyle(color: Colors.greenAccent),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 227, 220, 228),
                            ),
                          ),
                        ],
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
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: ElevatedButton.icon(
                              onPressed: (is_choice_a_an_image)
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        dialogTitle:
                                            'Question and Answer Image picking ',
                                      );

                                      if (result != null) {
                                        setState(() {
                                          absolute_path_a = result
                                              .files.single.path as String;
                                          choice_a_text =
                                              result.files.single.name;
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(Icons.attach_file),
                              label: const Text("Upload"),
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(172, 105, 240, 175))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                if (is_choice_a_an_image) {
                                  is_choice_a_an_image = false;
                                  choice_a_text = "Enter Choice A ?";
                                } else {
                                  is_choice_a_an_image = true;
                                }

                                setState(() {
                                  is_choice_a_an_image;
                                  choice_a_text;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows,
                                  color: Colors.greenAccent, size: 35),
                              label: const Text(''),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 500,
                              child: choice_widget_builder(choice_a_text,
                                  choice_a_controller, is_choice_a_an_image),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 80, horizontal: 50),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: ElevatedButton.icon(
                              onPressed: (is_choice_c_an_image)
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        dialogTitle:
                                            'Question and Answer Image picking ',
                                      );

                                      if (result != null) {
                                        setState(() {
                                          absolute_path_c = result
                                              .files.single.path as String;
                                          choice_c_text =
                                              result.files.single.name;
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(Icons.attach_file),
                              label: const Text("Upload"),
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(172, 105, 240, 175))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                if (is_choice_c_an_image) {
                                  is_choice_c_an_image = false;
                                  choice_c_text = "Enter Choice C ?";
                                } else {
                                  is_choice_c_an_image = true;
                                }

                                setState(() {
                                  is_choice_c_an_image;
                                  choice_c_text;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows,
                                  color: Colors.greenAccent, size: 35),
                              label: const Text(''),
                            ),
                          ),
                          Flexible(
                            child: Container(
                                width: 500,
                                child: choice_widget_builder(choice_c_text,
                                    choice_c_controller, is_choice_c_an_image)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: ElevatedButton.icon(
                              onPressed: (is_choice_b_an_image)
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        dialogTitle:
                                            'Question and Answer Image picking ',
                                      );

                                      if (result != null) {
                                        setState(() {
                                          absolute_path_b = result
                                              .files.single.path as String;
                                          choice_b_text =
                                              result.files.single.name;
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(Icons.attach_file),
                              label: const Text("Upload"),
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(172, 105, 240, 175))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                if (is_choice_b_an_image) {
                                  is_choice_b_an_image = false;
                                  choice_b_text = "Enter Choice B ?";
                                } else {
                                  is_choice_b_an_image = true;
                                }

                                setState(() {
                                  is_choice_b_an_image;
                                  choice_b_text;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows,
                                  color: Colors.greenAccent, size: 35),
                              label: const Text(''),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder(choice_b_text,
                                  choice_b_controller, is_choice_b_an_image),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 80, horizontal: 50),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: ElevatedButton.icon(
                              onPressed: (is_choice_d_an_image)
                                  ? () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        dialogTitle:
                                            'Question and Answer Image picking ',
                                      );

                                      if (result != null) {
                                        setState(() {
                                          absolute_path_d = result
                                              .files.single.path as String;
                                          choice_d_text =
                                              result.files.single.name;
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(Icons.attach_file),
                              label: const Text("Upload"),
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(172, 105, 240, 175)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                if (is_choice_d_an_image) {
                                  is_choice_d_an_image = false;
                                  choice_d_text = "Enter Choice D ?";
                                } else {
                                  is_choice_d_an_image = true;
                                }

                                setState(() {
                                  is_choice_d_an_image;
                                  choice_d_text;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows,
                                  color: Colors.greenAccent, size: 35),
                              label: const Text(''),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 600,
                              child: choice_widget_builder(choice_d_text,
                                  choice_d_controller, is_choice_d_an_image),
                            ),
                          ),
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
                                  child: const DropDownButtonWidget(),
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
                                  List absolutePathList = [
                                    absolute_path_a,
                                    absolute_path_b,
                                    absolute_path_c,
                                    absolute_path_d,
                                    absolute_path_question
                                  ];

                                  List of_choices_made = [
                                    is_choice_a_an_image,
                                    is_choice_b_an_image,
                                    is_choice_c_an_image,
                                    is_choice_d_an_image,
                                    is_question_an_image
                                  ];
                                  List of_text_of_choices = [
                                    choice_a_controller,
                                    choice_b_controller,
                                    choice_c_controller,
                                    choice_d_controller,
                                    question_controller
                                  ];

                                  Map choice_a_save = {};
                                  Map choice_b_save = {};
                                  Map choice_c_save = {};
                                  Map choice_d_save = {};
                                  Map question_save = {};

                                  List preparing_for_return = [];

                                  for (int i = 0; i <= 4; i++) {
                                    var data_of_fields = "";
                                    var flag_code = 1;

                                    if (of_choices_made[i]) {
                                      flag_code = 2;
                                      data_of_fields = absolutePathList[i];
                                    } else {
                                      data_of_fields =
                                          of_text_of_choices[i].text;
                                    }
                                    preparing_for_return
                                        .add({flag_code: data_of_fields});
                                  }

                                  if (question_saver_to_db(
                                      preparing_for_return, choice)) {
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
