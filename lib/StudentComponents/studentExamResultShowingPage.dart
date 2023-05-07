import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/ScoreModel.dart';
import '../Models/StudentModels.dart';
import 'StudentMainLandingPage.dart';


class StudentFinalResultView extends StatefulWidget {
	

   StudentFinalResultView(this.studentObject , this.tottalQuestion, this.correctAnswer, this.incorrectAnswer, this.isFinished);
   int tottalQuestion;
   int correctAnswer;
   int incorrectAnswer;
   Student studentObject; 
   bool isFinished;

  @override
  State<StudentFinalResultView> createState() =>
      StudentResultViewPageState();
}


class StudentResultViewPageState extends State<StudentFinalResultView> {

  Future openDialog() => showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title: const Text("No available Questions"),
            elevation: 8,
            icon: const Icon(
                    Icons.gpp_bad,
                    weight: 50,
                    size: 50,
                  ),
            iconColor:  Colors.redAccent,
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
                "This question catagory doesn't contain any question inserted for now! try again some other time or contact the adminstrator ",
              ),
            ),

            actions: [
              ElevatedButton.icon(
                  style:const ButtonStyle(
                      padding:  MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor:  MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                     Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text(
                     "Close and re-try",
                    style:  TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ));
  
    @override
    Widget build(BuildContext context) {
    

    int tottalQuestion = widget.tottalQuestion;
    int correctAnswer = widget.correctAnswer;
    int incorrectAnswer = widget.incorrectAnswer; 
    Student studentObject = widget.studentObject;
    bool isFinished = widget.isFinished;


    int averageQuestion =( double.parse( ((tottalQuestion * 2 ) * ( 74/100)).toString())).toInt();
 
    bool checkerifPassedOrFailed = correctAnswer * 2 >= averageQuestion;
    

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
      child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      width: 1000,
                      height: 700,
                      child: Column(
                        children: [
                           Container(
                            child:const Text('የፈተናዉ ውጤት', style: TextStyle(color: Colors.black54, decoration: TextDecoration.none),),   
                          ),
                          Container(
                            width: 1000,
                            height: 640,
                            child: Card(
                              color:const Color.fromRGBO(255, 239, 186, 0.405),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: const Color.fromRGBO(255, 239, 186, 1),
                              child:Container(
                                margin: EdgeInsets.symmetric(vertical: 100),
                                child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(children: [
                                    
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: 700,
                                     
                                      child: Row(children: [
                                        Text( (isFinished)?'ሰዐት በተገቢ ሁኔታ ተጠቅመዋል ':'የተሰጠውን ጥያቄዎች በተሰጠው ሰአት መጨረስ አልቻሉም', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey),),
                                        
                                      ]),
                                       ),

                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: 700,
                                      height: 50,
                                      child: Row(children: [
                                        Text('ጠቅላላ የተሰጠው ጥያቄ ብዛት ፡ ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, decoration: TextDecoration.underline),),
                                        Container(margin: EdgeInsets.symmetric(horizontal: 8),),
                                        Text('${tottalQuestion}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                                        
                                      ]),
                                       ),
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 10),
                                     
                                      width: 700,
                                      height: 50,
                                       child: Row(children: [
                                        Text('በትክክል የተመለሱ ጥያቄ ብዛት ፡', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, decoration: TextDecoration.underline, color: Color.fromARGB(255, 49, 113, 51)),),
                                        Container(margin: EdgeInsets.symmetric(horizontal: 8),),
                                        Text('${correctAnswer}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green),),
                                        
                                      ]),
                                      
                                    ),
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 10),
                                      width: 700,
                                      height: 50,
                                     
                                      child: Row(children: [
                                        Text('በትክክል ያልተመለሱ ጥያቄ ብዛት ፡', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, decoration: TextDecoration.underline, color: Color.fromARGB(255, 170, 50, 42)),),
                                        Container(margin: EdgeInsets.symmetric(horizontal: 8),),
                                        Text('${incorrectAnswer}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.red),),
                                        
                                      ]),
                                    
                                    ),
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 50),
                                     
                                      width: 700,
                                      height: 50,
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.gpp_good_rounded, color:(checkerifPassedOrFailed)? Colors.green :Colors.redAccent, size: 40,),
                                          Container(margin: EdgeInsets.symmetric(horizontal: 5),),
                                          Text( (checkerifPassedOrFailed)?'አልፈዋል' : 'አላለፉም', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, decoration: TextDecoration.underline),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],)
                                ],
                                ),
                              )
                  ) 
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                      Container(
                      
                        margin: EdgeInsets.symmetric(vertical: 50),
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(  backgroundColor: MaterialStatePropertyAll(Colors.blueGrey,),),
                          onPressed: () async{
                       
                            DateTime now = new DateTime.now();
                            DateTime date = new DateTime(now.year, now.month, now.day);
                            Box<StudentScoreModel> scoreModel= StudentScoreBox.getAllStudentsScore();
                            StudentScoreModel model = StudentScoreModel({studentObject.id_number.toString() : [date, tottalQuestion , correctAnswer, incorrectAnswer, checkerifPassedOrFailed, isFinished]});
                            await scoreModel.add(model);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                                return StudentMainLandingPageWidget(studentObject);
                            }),
                        );
                        } 
                        , child: Text('ወደ ዋናው ገዕ')),
                      )
                ]
              )
            ]
          )
      )
  );
  }
}
