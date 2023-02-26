import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './privillageChoosingPage.dart';
import './adminLandingPage.dart';

class AdminLoginPageWidget extends StatefulWidget {
  const AdminLoginPageWidget({super.key});

  @override
  State<AdminLoginPageWidget> createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLoginPageWidget> {
  final _userNameOfAdmin = TextEditingController();
  final _passwordOfAdmin = TextEditingController();
  bool _username_error = false;
  bool _username_correct = false;
  bool _password_correct = false;
  bool _password_error = false;

  void fieldCheckerAndManipulator(String fieldValue) {
    if ((fieldValue.toString().trim() == dotenv.env['userName1'] ||
        _userNameOfAdmin.text.trim() == dotenv.env['userName2'] ||
        _userNameOfAdmin.text.trim() == dotenv.env['userName3'])) {
      _username_correct = true;
      _username_error = false;
    } else {
      // change the border line of the username field only
      _username_correct = false;
      _username_error = true;
    }

    setState(() {
      _username_error = _username_error;
      _username_correct = _username_correct;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: 100,
                height: 40,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) {
                          return PrivillageChossingPage();
                        }),
                      );
                    },
                    icon: const Icon(Icons.backspace_rounded),
                    label: const Text(
                      "Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/entranceImageLogo.jpg',
                  fit: BoxFit.cover,
                  width: screenWidth * 0.16,
                  height: screenHeight * 0.25,
                  opacity: const AlwaysStoppedAnimation(0.7),
                ),
              )),
          const Text(
            "Login As Admin",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 30,
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              height: 2,
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
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 650,
            height: 300,
            child: Material(
              color: const Color.fromARGB(255, 186, 198, 187).withOpacity(0.3),
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    (_username_error)
                        ? TextField(
                            onChanged: (val) {
                              fieldCheckerAndManipulator(val);
                            },
                            controller: _userNameOfAdmin,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                icon: Icon(Icons.abc),
                                iconColor: Color.fromARGB(255, 213, 207, 214),
                                labelText: "Enter Correct User Name",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 220, 16, 16)),
                                hoverColor: Colors.amberAccent),
                            cursorColor:
                                const Color.fromARGB(255, 227, 220, 228),
                          )
                        : (_username_correct)
                            ? TextField(
                                onChanged: (val) {
                                  fieldCheckerAndManipulator(val);
                                },
                                controller: _userNameOfAdmin,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 30, 186, 79))),
                                    icon: Icon(Icons.abc),
                                    iconColor:
                                        Color.fromARGB(255, 213, 207, 214),
                                    labelText: "Enter Correct User Name",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 186, 79)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              )
                            : TextField(
                                onChanged: (val) {
                                  fieldCheckerAndManipulator(val);
                                },
                                controller: _userNameOfAdmin,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.abc),
                                    iconColor:
                                        Color.fromARGB(255, 213, 207, 214),
                                    labelText: "User Name",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 194, 184, 184)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 227, 220, 228),
                              ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    (_password_error)
                        ? TextField(
                            controller: _passwordOfAdmin,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                icon: Icon(Icons.password),
                                iconColor: Color.fromARGB(255, 208, 200, 209),
                                labelText: "Enter Correct PassWord",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 200, 51, 51)),
                                hoverColor: Colors.amberAccent),
                            cursorColor:
                                const Color.fromARGB(255, 215, 208, 216),
                          )
                        : (_password_correct)
                            ? TextField(
                                controller: _passwordOfAdmin,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 23, 215, 42))),
                                    icon: Icon(Icons.password),
                                    iconColor:
                                        Color.fromARGB(255, 208, 200, 209),
                                    labelText: "Enter Correct PassWord",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 23, 215, 42)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 215, 208, 216),
                              )
                            : TextField(
                                controller: _passwordOfAdmin,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.password),
                                    iconColor:
                                        Color.fromARGB(255, 208, 200, 209),
                                    labelText: "PassWord",
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 194, 184, 184)),
                                    hoverColor: Colors.amberAccent),
                                cursorColor:
                                    const Color.fromARGB(255, 215, 208, 216),
                              ),
                    Container(
                      width: 250,
                      height: 40,
                      margin: const EdgeInsets.only(top: 80),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(18),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            if ((_userNameOfAdmin.text.trim() ==
                                    dotenv.env['userName1'] ||
                                _userNameOfAdmin.text.trim() ==
                                    dotenv.env['userName2'] ||
                                _userNameOfAdmin.text.trim() ==
                                    dotenv.env['userName3'])) {
                              _username_correct = true;
                              _username_error = false;

                              if ((_passwordOfAdmin.text.trim() ==
                                  dotenv.env['password'])) {
                                _password_correct = true;
                                _password_error = false;

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                    return AdminLandingPageWidget();
                                  }),
                                );
                              } else {
                                _password_correct = false;
                                _password_error = true;
                              }
                            } else {
                              // change the border line of the username field only
                              _username_correct = false;
                              _username_error = true;
                            }

                            setState(() {
                              _username_error = _username_error;
                              _password_error = _password_error;
                              _username_correct = _username_correct;
                              _password_correct = _password_correct;
                            });
                          },
                          child: const Text(
                            "Add Purchase",
                            style: TextStyle(
                                color: Color.fromARGB(255, 250, 249, 251),
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
