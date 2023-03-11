import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './privillageChoosingPage.dart';
import '../Models/QuestionModel.dart';
import 'package:hive/hive.dart';

Future<int> heavyBackgroundTask(int x) async {
  //  fetch if any data is its not in sync with the current database
  // and load it to the database  [ hive ]
  //  for now just add some delay and proceed to the next page
  

  return 1;
}

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  Future<bool> compute_methodCallerSimpleFunction() async {
    await compute(heavyBackgroundTask, 1);

    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> flag = compute_methodCallerSimpleFunction();
    // print(flag.asStream().elementAt(1));
    flag.then((value) => {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) {
              return PrivillageChossingPage();
            }),
          )
        });

    return Container(
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
      child: Column(
        children: [
          const Text(
            "Car Driving Licence Traning Center",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 65,
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              height: 3,
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
          Container(margin: const EdgeInsets.symmetric(vertical: 80)),
          // CircularProgressIndicator(),
          const SpinKitWave(
            color: Color.fromARGB(255, 176, 160, 160),
            size: 100.0,
          ),
        ],
      ),
    );
  }
}
