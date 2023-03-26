import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Components/splashScreen.dart';
import './Models/QuestionModel.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionAdapter());

  // creating Question Information Box For Holding All The Questions
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool firstTime = (prefs.getBool('first_run') == true )? true: false;

  Box questionmodelBox = await Hive.openBox<Question>('QuestionInformatioMainModel');
  Box currentWorkingDirectory = await Hive.openBox('CurrenWorkingDirectory');

  if ( !firstTime) {
    
       await prefs.setBool('first_run', true);
  
      await  questionmodelBox.deleteFromDisk();
      await  currentWorkingDirectory.deleteFromDisk();

      questionmodelBox = await Hive.openBox<Question>('QuestionInformatioMainModel');
      currentWorkingDirectory = await Hive.openBox('CurrenWorkingDirectory');

      var CWD = Hive.box('CurrenWorkingDirectory');
      await CWD.put('cwd', null);

  }

 
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
