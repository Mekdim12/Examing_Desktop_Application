import 'package:flutter/material.dart';
import './sideBarDrawer.dart';
import './adminTypeOfQuestionChossingPage.dart';

class QuestionManagementLandingPage extends StatelessWidget {
  const QuestionManagementLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Scaffold(
          drawer: const SidebarDrawerWidget(2),
          appBar: AppBar(
            foregroundColor: const Color(0xFFF5EBE0).withOpacity(1),
            backgroundColor: const Color(0xFF65647C),
            title: const Text(
              'Question Management',
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.symmetric(vertical: screenHeight / 6),
              child: Column(
                children: [
                  const Text(
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
                  Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.store_rounded),
                      label: const Text("Manage Stored Questions"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 25))),
                      onPressed: () {
                        
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.question_mark),
                      label: const Text("Insert New Questions"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 112, vertical: 25))),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (ctx) {
                          return QuestionTypeChoosingPage();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
