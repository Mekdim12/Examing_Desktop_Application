import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './Components/splashScreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyMainHompePage());
}

class MyMainHompePage extends StatefulWidget {
  const MyMainHompePage({super.key});

  @override
  State<MyMainHompePage> createState() => _MyMainHompePageState();
}

class _MyMainHompePageState extends State<MyMainHompePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: splashScreen(),
      ),
    );
  }
}
