import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import '../Components/privillageChoosingPage.dart';
import '../Components/adminLandingPage.dart';
import './QuestionTypeChoosingPage.dart';
import './studentLoginPage.dart';
import '../Models/StudentModels.dart';
import 'StudentFavQuestionsDisplayingPage.dart';

class StudentMainLandingPageWidget extends StatefulWidget {
   StudentMainLandingPageWidget(this.studentObject);

   Student studentObject;

  @override
  State<StudentMainLandingPageWidget> createState() =>
      StudentMainLandingState();
}

class StudentMainLandingState extends State<StudentMainLandingPageWidget> {
  Future openDialog() => showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(15),
            title:Container(
                        // width: 50,
                        height: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                    
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/images/mainBackground.jpg'),
                            ),
                        )
                      ),
            elevation: 8,
            
            // backgroundColor: Color.fromARGB(225, 241, 237, 237),
            contentTextStyle: const TextStyle(
                color: Color.fromARGB(255, 25, 57, 42),
                fontWeight: FontWeight.bold),
            content: Container(
              alignment: Alignment.center,
              width: 600,
              height: 350,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child:Container(
                child: Column(
                  children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Software Developer : "),Text("መቅድም ታምራት", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black54),)],
                            ),


                            Container(
                              margin: EdgeInsets.all(15),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ለማንኛው ከሶፍትዌር ጋር የተያያዙ ስራዎች እንደሁም ማማክርን ጨምሮ የስልክ አፕልኬሽን፣\n ዊብሳይቶች፣ ቦት፣ ሶፍትዌሮች ከማማክር ጋር በተመጣጣኝ ዋጋ እንሰራለን።ለድርጅቶ ለሚያስፈልጉ\n ማንኛውም ሶፍትዌርች መስራት ማማከር አንዲሁም እጫጭር ስልጠና መሰጠት እንሰራለን። \nለተማሪዎች የፕሮግራሚንግ ስልጠና መስጠት አንዲሁም የማስተርስን ጨምሮ ፕሮጀክቶችን \nመስራት ለተጨማራ ጥያቄ በሚክተሉት እድራሻዎች ያግኙን ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, ),textAlign: TextAlign.justify,)],
                            ),),

                            Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 50, top: 15, bottom: 5),),
                                ImageIcon(AssetImage('assets/images/mainBackground.jpg')),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                Text("ሰልክ ቁጥር፡ 0924041650")

                              ],
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 50, top: 15, bottom: 5),),
                                ImageIcon(AssetImage('assets/images/mainBackground.jpg')),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                Text("Instaram: @mekdim_tam")

                              ],
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 50, top: 15, bottom: 5),),
                                ImageIcon(AssetImage('assets/images/mainBackground.jpg')),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                Text("telegram: @mekdim_tamirat")

                              ],
                            ),
                          Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 50, top: 15, bottom: 5),),
                                ImageIcon(AssetImage('assets/images/mainBackground.jpg')),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                Text("facebook: mekdim_tam")

                              ],
                            ),
                            Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 50, top: 15, bottom: 5),),
                                ImageIcon(AssetImage('assets/images/mainBackground.jpg')),
                                Container(margin: EdgeInsets.symmetric(horizontal: 10),),
                                Text("linkdin: mekdim_tamirat")

                              ],
                            )
                  ],
                ),
              )
            ),

            actions: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
                      iconColor: const MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                    Navigator.of(context).pop();
                   
                  },
                  icon: const Icon(Icons.close),
                  label: Text(
                    "ተመለስ",
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
                                                onPressed: (){
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (ctx) {
                                                      return StudentFavoriteFirstPageWidget(object);
                                                    }),
                                                  );
                                                  
                                                },
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
                                                onPressed: (){
                                                  openDialog();
                                                },
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
