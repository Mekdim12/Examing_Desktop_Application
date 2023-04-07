import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import './QuestionTypeChoosingPage.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';

class StudentMainLandingPageWidget extends StatefulWidget {
   StudentMainLandingPageWidget(this.studentObject);

   Student studentObject;

  @override
  State<StudentMainLandingPageWidget> createState() =>
      StudentMainLandingState();
}

class StudentMainLandingState extends State<StudentMainLandingPageWidget> {
  Future openDialog(bool good_or_bad) => showDialog(
      barrierDismissible: true,
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
                    (good_or_bad)
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) {
                              return StudentLoginPageWidget();
                            }),
                          )
                        : null;
                  },
                  icon: const Icon(Icons.close),
                  label: Text(
                    (good_or_bad)
                        ? "Close & go to Login page"
                        : "Close and re-try",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    Student object = widget.studentObject;
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
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black38),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return StudentLoginPageWidget();
                        }),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Logout",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: screenHeight / 12),
              child: Row(
                children: [
                  Container(
                      width: 600,
                      height: 600,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Welcome, ${object.fullName.toString().trim()}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          decoration: TextDecoration.none)),
                                     ],
                              )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("አንኳን ደህና መጡ",
                                  style: TextStyle(
                                      fontSize: 25, 
                                      color: Colors.black54,
                                      decoration: TextDecoration.none)),
                            ],
                          )),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1000,
                      height: 700,
                      child: Column(
                        children: [
                          Container(
                            child: Text('ወዴት መሄድ ይፈልጋሉ ?', style: TextStyle(color: Colors.black54, decoration: TextDecoration.none),),
                            
                          ),
                          Container(
                            width: 1000,
                            height: 600,
                            child: Card(
                              color: Color.fromRGBO(255, 239, 186, 0.405),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: Color.fromRGBO(255, 239, 186, 1),
                              child: Container(
                                
                                margin: EdgeInsets.symmetric(vertical: 50),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.directions,size: 50), 
                                            Container(
                                              width: 500,
                                              margin: EdgeInsets.only(left: 25),
                                              height: 60,
                                              child:ElevatedButton(
                                                onPressed: (){
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                      return QuestionTypeChossingPage('1' ,object);
                                                    }),
                                                  );
                                                },
                                                child: Text("ፈተና ለመለማመድ", style: TextStyle(fontFamily: 'openSans', fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Colors.green)),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                       Container(
                                     margin: const EdgeInsets.symmetric(vertical: 15),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.time_to_leave_outlined,size: 50), 
                                            Container(
                                              width: 500,
                                              height: 60,
                                                margin: EdgeInsets.only(left: 25),
                                              child:ElevatedButton(
                                                onPressed: (){
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                      return QuestionTypeChossingPage('2' ,object);
                                                    }),
                                                  );
                                                },
                                                child: Text("ፈተና ለመፈተን", style: TextStyle(fontFamily: 'openSans', fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Colors.green)),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                       
                                      Container(
                                          margin: EdgeInsets.symmetric(vertical: 15),
                                          child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.saved_search,size: 50), 
                                            Container(
                                              width: 500,
                                              height: 60,
                                                margin: EdgeInsets.only(left: 25),
                                              child:ElevatedButton(
                                                onPressed: (){},
                                                child: Text("የተቀመጡ ጥያቄዎች", style: TextStyle(fontFamily: 'openSans', fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Colors.green)),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(vertical: 15),
                                          child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.info,size: 50), 
                                            Container(
                                              width: 500,
                                              height: 60,
                                                margin: EdgeInsets.only(left: 25),
                                              child:ElevatedButton(
                                                onPressed: (){},
                                                child: Text("እጠቃላይ መረጃዎች", style: TextStyle(fontFamily: 'openSans', fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Colors.green)),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                       Container(
                                          margin: EdgeInsets.symmetric(vertical: 15),
                                          child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.code,size: 50), 
                                            Container(
                                              width: 500,
                                              height: 60,
                                              margin: EdgeInsets.only(left: 25),
                                              child:ElevatedButton(
                                                onPressed: (){},
                                                child: Text("ሰለ ሶፍትዌሩ ", style: TextStyle(fontFamily: 'openSans', fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Colors.green)),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                  ],
                                ),
                              )
                            ),
                          )
                        ],
                      ))





                ],
              ))
        ],
      ),
    );
  }
}
