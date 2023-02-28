import 'package:flutter/material.dart';
import './adminTypeOfQuestionChossingPage.dart';

class ImageBasedQuesionInsertingPageWidget extends StatefulWidget {
  const ImageBasedQuesionInsertingPageWidget({super.key});

  @override
  State<ImageBasedQuesionInsertingPageWidget> createState() =>
      _ImageBasedQuesionInsertingPageState();
}

class _ImageBasedQuesionInsertingPageState
    extends State<ImageBasedQuesionInsertingPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
          backgroundColor: const Color(0xFF65647C),
          leadingWidth: 150,
          leading: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(164, 101, 100, 124)),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) {
                      return const QuestionTypeChoosingPage();
                    }),
                  );
                },
                icon: const Icon(Icons.backspace_rounded),
                label: const Text(
                  "Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ),
          title: const Text(
            'Text Based Questions',
            style: TextStyle(
                color: Color.fromARGB(255, 217, 217, 225),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                iconSize: 35,
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
