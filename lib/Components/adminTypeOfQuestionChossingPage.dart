import 'package:flutter/material.dart';
import './adminQuestionManagementMenuPage.dart';
import './adminTextBasedQuestionInsertingPage.dart';
import './adminImageBasedQuestionInsertingPage.dart';

class QuestionTypeChoosingPage extends StatelessWidget {
  const QuestionTypeChoosingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Color.fromARGB(164, 101, 100, 124)),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) {
                      return QuestionManagementLandingPage();
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
            'Question Inserting Type',
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
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundEntrance.jpg'),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(50, 20),
                        blurRadius: 10,
                      ),
                    ],
                    color: Color.fromARGB(199, 255, 255, 255),
                    fontFamily: 'openSans',
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.abc),
                        label: const Text("Insert Text Based Questions"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(188, 76, 175, 79)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 130, vertical: 25))),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                            return TextBasedQuestionInsertingPageWidget();
                          }));
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text("Insert Image Based Questions"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(188, 76, 175, 79)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 122, vertical: 25))),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                            return ImageBasedQuesionInsertingPageWidget();
                          }));
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.import_export),
                        label: const Text("Export Questions For Sharing"),
                        style: ButtonStyle(
                            side: const MaterialStatePropertyAll(
                                BorderSide(color: Colors.green)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(207, 71, 86, 72)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 122, vertical: 25))),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) {
                            return QuestionTypeChoosingPage();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
