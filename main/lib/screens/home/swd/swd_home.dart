import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/login/login_screen.dart';

class SwdHome extends StatefulWidget {
  final String? emailText;
  const SwdHome({super.key, required this.emailText});
  @override
  State<SwdHome> createState() => _SwdHomeState();
}

class _SwdHomeState extends State<SwdHome> {
  final TextStyle customTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );
  int positon = 0;
  String text = "Profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade600,
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              shadows: [
                Shadow(
                    blurRadius: 2.0,
                    offset: const Offset(1.0, 1.0),
                    color: Colors.grey.shade900)
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: "Logout",
              onPressed: () {
                print("Logout");
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen())))
                    .onError((error, stackTrace) {
                  print("Error occured due to " + error.toString());
                });
              },
              icon: const Icon(Icons.logout),
              color: Colors.white,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: positon,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.white,
          iconSize: 30,
          backgroundColor: Colors.orange.shade600,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_search_sharp), label: "Find a Scribe"),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: "Requests"),
          ],
          onTap: (value) {
            setState(() {
              positon = value;
              switch (value) {
                case 0:
                  text = "Profile";
                  break;
                case 1:
                  text = "Find a Scribe";
                  break;
                case 2:
                  text = "My Requests";
                  break;
                default:
              }
            });
          },
        ),
        body: Container(
             decoration: const BoxDecoration(
                // color: Color.fromRGBO(227, 161, 43, 0.3),
              ),
        ),
    );
  }
}
