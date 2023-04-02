import 'package:flutter/material.dart';
import './Admin_login_page.dart';
import '../StudentComponents/studentLoginPage.dart';

class PrivillageChossingPage extends StatelessWidget {
  const PrivillageChossingPage({super.key});

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text("Login As Admin"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) {
                        return AdminLoginPageWidget();
                      }),
                    );
                  },
                ),
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
            "Choose How You Want To Proceed",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontStyle: FontStyle.normal,
              color: Colors.white70,
              height: 3,
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
            margin: const EdgeInsets.symmetric(vertical: 100),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text("Login As Student"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 70, vertical: 25))),
              onPressed: () {
                 Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) {
                    return StudentLoginPageWidget();
                  }),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
