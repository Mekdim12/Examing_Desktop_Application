import 'package:diving_licence_traning_center_student/Models/StudentModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import './studentRegisterationPage.dart';
import '../Models/ScoreModel.dart';

class StudentLoginPageWidget extends StatefulWidget {
  const StudentLoginPageWidget({super.key});

  @override
  State<StudentLoginPageWidget> createState() => StudentLoginPageState();
}

class StudentLoginPageState extends State<StudentLoginPageWidget> {
  final _passwordOfAdmin = TextEditingController();
  bool _password_correct = false;
  bool _password_error = false;
  final _userNameOfAdmin = TextEditingController();
  bool _username_correct = false;
  bool _username_error = false;

  void fieldCheckerAndManipulator(String fieldValue) {
    if ((fieldValue.toString().trim() == dotenv.env['userName1'] ||
        _userNameOfAdmin.text.trim() == dotenv.env['userName2'] ||
        _userNameOfAdmin.text.trim() == dotenv.env['userName3'])) {
      _username_correct = true;
      _username_error = false;
    } else {
      // change the border line of the username field only
      _username_correct = false;
      _username_error = true;
    }

    setState(() {
      _username_error = _username_error;
      _username_correct = _username_correct;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: const BoxConstraints.expand(),
      width: double.infinity,
    
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
         gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                 0.2,
                 0.9,
                 0.4
              ],

              colors: [
                Color.fromRGBO(255,239,186, 1),
                Color.fromRGBO(255,255,255, 1),
                Color.fromRGBO(255,255,255, 1),
              ],
            )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return PrivillageChossingPage();
                        }),
                      );
                    },
                    icon: const Icon(Icons.backspace_rounded),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 70)
          ),
          const Text(
            "Login As Student",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 40,
              fontStyle: FontStyle.normal,
              color: Color.fromARGB(179, 30, 29, 29),
              height: 2,
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
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: 850,
            height: 450,
            child: Material(
              color: const Color.fromARGB(255, 88, 90, 88).withOpacity(0.3),
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Container(margin:const EdgeInsets.symmetric(vertical: 20),),
                    (_username_error)
                        ? TextField(
                            onChanged: (val) {
                              fieldCheckerAndManipulator(val);
                            },
                            controller: _userNameOfAdmin,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                icon: Icon(Icons.abc, size: 40),
                                iconColor: Color.fromRGBO(0, 0, 0, 1),
                              
                                labelText: "Enter Correct Student Id",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 220, 16, 16)),
                                hoverColor: Colors.amberAccent),
                            cursorColor:
                                const Color.fromARGB(255, 227, 220, 228),
                          )
                        : (_username_correct)
                            ? TextField(
                                onChanged: (val) {
                                  fieldCheckerAndManipulator(val);
                                },
                                controller: _userNameOfAdmin,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 30, 186, 79))),
                                   icon: Icon(Icons.abc, size: 40),
                                  iconColor: Color.fromRGBO(0, 0, 0, 1),
                                    labelText: "Student Id ✓",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 186, 79)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              )
                            : TextField(
                                onChanged: (val) {
                                  fieldCheckerAndManipulator(val);
                                },
                                controller: _userNameOfAdmin,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                                decoration: const InputDecoration(
                                     icon: Icon(Icons.abc, size: 40),
                                  iconColor: Color.fromRGBO(0, 0, 0, 1),
                                    labelText: " Enter student id",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(0, 0, 0, 1)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    (_password_error)
                        ? TextField(
                           style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                            controller: _passwordOfAdmin,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                               icon: Icon(Icons.password,size: 40,),
                                    iconColor:
                                        Color.fromRGBO(0, 0, 0, 1),
                                labelText: "Enter Correct PassWord",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 200, 51, 51)),
                                hoverColor: Colors.amberAccent),
                            cursorColor:
                                const Color.fromARGB(255, 215, 208, 216),
                          )
                        : (_password_correct)
                            ? TextField(
                               style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                                controller: _passwordOfAdmin,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 23, 215, 42))),
                                    icon: Icon(Icons.password,size: 40,),
                                    iconColor:
                                        Color.fromRGBO(0, 0, 0, 1),
                                    labelText: "Enter Correct PassWord",
                                    labelStyle: TextStyle(
                                        color:
                                             Color.fromRGBO(0, 0, 0, 1)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 215, 208, 216),
                              )
                            : TextField(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                                controller: _passwordOfAdmin,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.password,size: 40,),
                                    iconColor:
                                        Color.fromRGBO(0, 0, 0, 1),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                        color:
                                             Color.fromRGBO(0, 0, 0, 1)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 215, 208, 216),
                              ),
                    Container(
                      width: 250,
                      height: 50,
                      margin: const EdgeInsets.only(top: 80),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(18),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {

                            Box<Student> allStudentInfo = StudentBox.getAllTheStudentsInfo();
                            if(!(_userNameOfAdmin.text.trim().isEmpty || _passwordOfAdmin.text.trim().isEmpty )){
                                for(var value in allStudentInfo.toMap().values){
                                
                                
                                  if(_userNameOfAdmin.text.trim() == value.id_number && _passwordOfAdmin.text.trim() == value.password){
                                        
                                      return;
                                  }
                                }
                            }

                           setState(() {
                              _username_error = true;
                              _password_error = true;
                           
                            });
                            
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 250, 249, 251),
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(margin: EdgeInsets.symmetric(vertical: 15),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [TextButton.icon(onPressed: (){
                           Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentRegisterationPageWidget();
                        }),
                      );
                      }, icon:const  Icon(Icons.app_registration_rounded, color:   Color.fromARGB(255, 23, 215, 42),), label: const Text('Register New Student' , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black, decoration: TextDecoration.underline)))],
                    )
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
