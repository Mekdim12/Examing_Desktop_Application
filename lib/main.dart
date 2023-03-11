import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './Components/splashScreen.dart';
import './Models/QuestionModel.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionAdapter());

  // creating Question Information Box For Holding All The Questions
  await Hive.openBox<Question>('QuestionInformatioModel_Trial2');
  await Hive.openBox('CurrenWorkingDirectory');

  runApp(MyMainHompePage());
}

class MyMainHompePage extends StatefulWidget {
  const MyMainHompePage({super.key});

  @override
  State<MyMainHompePage> createState() => _MyMainHompePageState();
}

class _MyMainHompePageState extends State<MyMainHompePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: splashScreen(),
      ),
    );
  }
}
