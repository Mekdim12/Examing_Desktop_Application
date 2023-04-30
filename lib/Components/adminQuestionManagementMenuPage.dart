import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './sideBarDrawer.dart';
import './adminTypeOfQuestionChossingPage.dart';
import './adminManageQuestions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Admin_login_page.dart';

class QuestionManagementLandingPage extends StatefulWidget {
  const QuestionManagementLandingPage({super.key});

  @override
  State<QuestionManagementLandingPage> createState() =>
      _QuestionManagementLandingPageState();
}

class _QuestionManagementLandingPageState
    extends State<QuestionManagementLandingPage> {
  bool is_CWD_file_located = false;


  Future openDialog(bool good_or_bad, int flag) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: (flag == 1)
                ? const Text("Notification")
                : (good_or_bad)
                    ? const Text("Success-Full Set Path")
                    : const Text("Unsuccess-Full  Operation"),
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
            iconColor: (flag == 1)
                ? Colors.amberAccent
                : (good_or_bad)
                    ? Colors.greenAccent
                    : Colors.redAccent,
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
                (flag == 1)
                    ? "You Have Already Set The Working Directory If You Really Want Change that Long Press The Button it will open the modal"
                    : (good_or_bad)
                        ? "You Have Success-fully Located Your Application Path"
                        : "The Operation Failed and The path You Located Can't Seem To BE Located",
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
                  label: Text(
                    (flag == 1)
                        ? "okay"
                        : (good_or_bad)
                            ? "Close"
                            : "Try Again",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ));




  @override
  Widget build(BuildContext context) {
      
    if (Hive.box('CurrenWorkingDirectory').get('cwd') != null) {
      is_CWD_file_located = true;
    } else {
      is_CWD_file_located = false;
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Scaffold(
          drawer: const SidebarDrawerWidget(2),
          appBar: AppBar(
            foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
            backgroundColor: const Color(0xFF65647C),
            title: const Text(
              'Question Management',
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.symmetric(vertical: screenHeight / 6),
              child: Column(
                children: [
                  const Text(
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
                  Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.store_rounded),
                      label: const Text("Manage Stored Questions"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 25))),
                      onPressed: (is_CWD_file_located)
                          ? () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                return QuestionManagementPageWidget();
                              }));
                            }
                          : null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.question_mark),
                      label: const Text("Insert New Questions"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 112, vertical: 25))),
                      onPressed: (is_CWD_file_located)
                          ? () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                return QuestionTypeChoosingPage();
                              }));
                            }
                          : null,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 20))),
                              onPressed: (is_CWD_file_located)
                                  ? () {
                                      openDialog(true, 1);
                                    }
                                  : () async {
                                      var folder_for_file = await FilePicker
                                          .platform
                                          .getDirectoryPath();
                                        if(folder_for_file != null){
                                             try {
                                                  var CWD =
                                                      Hive.box('CurrenWorkingDirectory');

                                                  Future<void> fulture_cwd =
                                                      CWD.put('cwd', folder_for_file);
                                                  fulture_cwd.then(
                                                    (value) {
                                                      openDialog(true, 0);
                                                      setState(() {
                                                        is_CWD_file_located = true;
                                                      });
                                                    },
                                                  );
                                            } catch (Exception) {
                                              var CWD = Hive.box('CurrenWorkingDirectory');
                                              await CWD.put('cwd', null);
                                               openDialog(false, 0);
                                                setState(() {
                                                        is_CWD_file_located = false;
                                                  });
                                            }
                                        }else{
                                          var CWD = Hive.box('CurrenWorkingDirectory');
                                          await CWD.put('cwd', null);
                                          openDialog(false, 0);
                                          setState(() {
                                                    is_CWD_file_located = false;
                                              });
                                        }
                                     
                                    },
                              onLongPress:() async {
                                      var folder_for_file = await FilePicker
                                          .platform
                                          .getDirectoryPath();
                                          if(folder_for_file != null){
                                                try {
                                                  var CWD =
                                                      Hive.box('CurrenWorkingDirectory');
                                                  await CWD.put('cwd', folder_for_file);
                                                  
                                                  setState(() {
                                                    is_CWD_file_located = true;
                                                  });

                                                  openDialog(true, 0);
                                                } catch (Exception) {
                                                    var CWD = Hive.box('CurrenWorkingDirectory');
                                                    await CWD.put('cwd', null);
                                                    openDialog(false, 0);
                                                    setState(() {
                                                            is_CWD_file_located = false;
                                                      });
                                                }
                                          }else{
                                            var CWD = Hive.box('CurrenWorkingDirectory');
                                            await CWD.put('cwd', null);
                                            openDialog(false, 0);
                                            setState(() {
                                                    is_CWD_file_located = false;
                                              });
                                          }
                                    },
                                 
                              icon: const Icon(Icons.upload),
                              label: const Text('Locate Installation Folder'),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
