import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Components/splashScreen.dart';
import './Models/QuestionModel.dart';
import './Models/StudentModels.dart';
import './Models/QuestionTypeModel.dart';
import './Models/StudentFavoriteModel.dart';
import './Models/ScoreModel.dart';
import 'package:desktop_window/desktop_window.dart';
/*


Size size = await DesktopWindow.getWindowSize();
    print(size);
    await DesktopWindow.setWindowSize(Size(500,500));

    await DesktopWindow.setMinWindowSize(Size(400,400));
    await DesktopWindow.setMaxWindowSize(Size(800,800));

    await DesktopWindow.resetMaxWindowSize();
    await DesktopWindow.toggleFullScreen();
    bool isFullScreen = await DesktopWindow.getFullScreen();
    await DesktopWindow.setFullScreen(true);
    await DesktopWindow.setFullScreen(false);
    
     */
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(QuestionTypeModelAdapter());
  Hive.registerAdapter(StudentFavoriteTypeModelAdapter());
  Hive.registerAdapter(StudentScoreModelAdapter());



  // creating Question Information Box For Holding All The Questions
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool firstTime = (prefs.getBool('first_run') == true )? true: false;

  Box questionmodelBox = await Hive.openBox<Question>('QuestionInformatioMainModel');
  Box currentWorkingDirectory = await Hive.openBox('CurrenWorkingDirectory');
  Box studentInformationBox = await Hive.openBox<Student>('StudentInformationMain');
  Box questionTypeBox = await Hive.openBox<QuestionTypeModel>('QuestionTypeMain');
  Box studentFav = await Hive.openBox<StudentFavoriteTypeModel>('StudentFavMain');
  Box studentScore = await Hive.openBox<StudentScoreModel>('StudentScoreMain');
  
  

  if ( !firstTime) {
    
      await prefs.setBool('first_run', true);
  
      await  questionmodelBox.deleteFromDisk();
      await  currentWorkingDirectory.deleteFromDisk();

      questionmodelBox = await Hive.openBox<Question>('QuestionInformatioMainModel');
      currentWorkingDirectory = await Hive.openBox('CurrenWorkingDirectory');
      studentInformationBox = await Hive.openBox<Student>('StudentInformationMain');
      questionTypeBox = await Hive.openBox<QuestionTypeModel>('QuestionTypeMain');
      studentFav = await Hive.openBox<StudentFavoriteTypeModel>('StudentFavMain');
      studentScore = await Hive.openBox<StudentScoreModel>('StudentScoreMain');
  
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
