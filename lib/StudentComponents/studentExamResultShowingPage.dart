import 'package:flutter/material.dart';
import '../Models/StudentModels.dart';




class StudentFinalResultView extends StatefulWidget {
	

   StudentFinalResultView();
   

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
                            height: 600,
                            child: Card(
                              color:const Color.fromRGBO(255, 239, 186, 0.405),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 20,
                              shadowColor: const Color.fromRGBO(255, 239, 186, 1),
                              child:Text("ddd")
                              ) ) ] ) ) );
  }
}
