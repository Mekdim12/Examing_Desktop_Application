// import 'package:flutter/material.dart';
// import './adminQuestionManagementMenuPage.dart';

// class QuestionManagementPage extends StatefulWidget {
//   const QuestionManagementPage({super.key});

//   @override
//   State<QuestionManagementPage> createState() => _QuestionManagementPage();
// }

// class _QuestionManagementPage extends State<QuestionManagementPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.zero,
//       padding: EdgeInsets.zero,
//       width: double.infinity,
//       height: double.infinity,
//       child: Scaffold(
//         appBar: AppBar(
//           foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
//           backgroundColor: const Color(0xFF65647C),
//           leadingWidth: 150,
//           leading: Container(
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//             child: ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                       Color.fromARGB(164, 101, 100, 124)),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (ctx) {
//                       return QuestionManagementLandingPage();
//                     }),
//                   );
//                 },
//                 icon:const Icon(Icons.backspace_rounded),
//                 label: const Text(
//                   "Back",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 )),
//           ),
//           title: const Text(
//             'Question Inserting Type',
//             style: TextStyle(
//                 color: Color.fromARGB(255, 217, 217, 225),
//                 fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//       ),
//     );
//   }
// }
