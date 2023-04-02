import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
class StudentRegisterationPageWidget extends StatefulWidget {
  const StudentRegisterationPageWidget({super.key});

  @override
  State<StudentRegisterationPageWidget> createState() => StudentRegisterationPageState();
}

class StudentRegisterationPageState extends State<StudentRegisterationPageWidget> {
 final fullnamecontroller = TextEditingController();
 final idnumbercontroller = TextEditingController();
 final password1controller = TextEditingController();
 final password2controller = TextEditingController();

Future openDialog(bool good_or_bad) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: (good_or_bad)
                ? const Text("Successfully Registered")
                : const Text("Not Registered"),
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
                    ? "You Have Success-fully Registred to the database now try login with these credentials"
                    : "The Operation Failed and The Data You Entered Is Not Inserted On The Database maybe try to correct your input entries mainly empty field insertion is not allowed and make sure the two passwords needs to be identical or maybe this id is already registred try contacting the admin",
              ),
            ),

            actions: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor: const MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll((good_or_bad)
                          ? Colors.greenAccent
                          : Colors.redAccent)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    (good_or_bad) ?
                     Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentLoginPageWidget();
                        }),
                      ) : null;
                  },
                  icon: const Icon(Icons.close),
                  label:  Text(
                     (good_or_bad) ?
                    "Close & go to Login page": "Close and re-try",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ));

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
                          return StudentLoginPageWidget();
                        }),
                      );
                    },
                    icon: const Icon(Icons.backspace_rounded),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10)
          ),
          const Text(
            "Register ✍",
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
            // height: 450,
            child: Material(
              color: Color.fromARGB(255, 88, 90, 88).withOpacity(0.3),
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Container(margin:const EdgeInsets.symmetric(vertical: 20),),
                    TextField(
                                controller: fullnamecontroller,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                decoration: const InputDecoration(
                                     icon: Icon(Icons.abc, size: 40),
                                  iconColor: Color.fromRGBO(0, 0, 0, 1),
                                    labelText: " Enter Full Name",
                                    labelStyle: TextStyle(
                                       fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(0, 0, 0, 1)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    TextField(
                                controller:idnumbercontroller ,
                                style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                                decoration: const InputDecoration(
                                icon: Icon(Icons.medical_information_outlined, size: 40),
                                iconColor: Color.fromRGBO(0, 0, 0, 1),
                                  labelText: " Enter id number",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromRGBO(0, 0, 0, 1)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                      TextField(
                      controller: password1controller,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.password,size: 40,),
                            iconColor:
                                Color.fromRGBO(0, 0, 0, 1),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                                color:
                                      Color.fromRGBO(0, 0, 0, 1)),
                            hoverColor: Colors.amberAccent),
                        cursorColor:
                            const Color.fromARGB(255, 215, 208, 216),
                          ),
                           Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                           TextField(
                            controller: password2controller,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.password,size: 40,),
                            iconColor:
                                Color.fromRGBO(0, 0, 0, 1),
                            labelText: "Enter Password again",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                                color:
                                      Color.fromRGBO(0, 0, 0, 1)),
                            hoverColor: Colors.amberAccent),
                        cursorColor:
                            Color.fromARGB(255, 215, 208, 216),
                          ),
                     Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                     
                    Container(
                      width: 270,
                      height: 60,
                      margin: const EdgeInsets.only(top: 60),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(18),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () async{

                              if (!(fullnamecontroller.text.trim().isEmpty || idnumbercontroller.text.trim().isEmpty||password1controller.text.trim().isEmpty || password2controller.text.trim().isEmpty)){
                                  if(password1controller.text.trim() == password2controller.text.trim()){
                                        // Insert into the database
                                         final db = StudentBox.getAllTheStudentsInfo();
                                         Box<Student> allStudentInfo = StudentBox.getAllTheStudentsInfo();
                                        
                                          for(var value in  allStudentInfo.toMap().values){
                                                if(value.id_number == idnumbercontroller.text.trim()){
                                                await openDialog(false);
                                                    return;
                                                }
                                          }

                                         Student student_infn_object = Student(fullnamecontroller.text.trim(), idnumbercontroller.text.trim(),password1controller.text.trim() );
                                         await db.add(student_infn_object);
                                         await openDialog(true);
                                         return;
                                  }
                              }
                            await openDialog(false);
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 18,
                                color: Color.fromARGB(255, 250, 249, 251),
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  
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
