import 'package:flutter/material.dart';
import './adminLandingPage.dart';
import './adminQuestionManagementMenuPage.dart';
import './Admin_login_page.dart';

class SidebarDrawerWidget extends StatefulWidget {
  final int activa_page;
  const SidebarDrawerWidget(this.activa_page, {super.key});

  @override
  State<SidebarDrawerWidget> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    int currentChoosenPage = widget.activa_page;

    return Drawer(
      width: 380,
      // shadowColor: const Color(0xFF65647C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      elevation: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF65647C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              width: double.infinity,
              height: 220,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                          elevation: MaterialStatePropertyAll(12),
                        ),
                        color: const Color(0xFFF5EBE0),
                        iconSize: 35,
                        hoverColor: Colors.blueGrey,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 110,
                    width: double.infinity,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/entranceImageLogo.jpg'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.all(4),
                    child: const Text(
                      "Welcom , Admin",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 1)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) {
                              return AdminLandingPageWidget();
                            }),
                          );
                        },
                        child: const Text(
                          'DashBoard',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 2)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) {
                              return QuestionManagementLandingPage();
                            }),
                          );
                        },
                        child: const Text(
                          'Manage Question',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    horizontalTitleGap: 1,
                    title: TextButton(
                        style: (currentChoosenPage == 3)
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 207, 158, 215)),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft)
                            : const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(25)),
                                alignment: Alignment.centerLeft),
                        onPressed: () {},
                        child: const Text(
                          'Manage Students',
                          style: TextStyle(
                              color: Color.fromARGB(222, 29, 29, 29),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomSheet: Container(
          height: 60,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color(0xFF65647C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Center(
              child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) {
                  return AdminLoginPageWidget();
                }),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          )),
        ),
      ),
    );
  }
}
