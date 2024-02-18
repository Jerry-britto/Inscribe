import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/home/swd/swd_findScribe.dart';
import 'package:main/screens/home/swd/swd_profile.dart';
import 'package:main/screens/home/swd/swd_requests.dart';
import 'package:main/screens/login/login_screen.dart';

class SwdHome extends StatefulWidget {
  final String? emailText;
  const SwdHome({super.key, required this.emailText});
  @override
  State<SwdHome> createState() => _SwdHomeState();
}

class _SwdHomeState extends State<SwdHome> {

  Widget displayScreen(int idx) {
    switch (idx) {
      case 0:
        return SwdProfile(emailText: widget.emailText);
      case 1:
        return const FindScribe();
      case 2:
        return const SwdRequests();
      default:
        return SwdProfile(emailText: widget.emailText);
    }
  }

  int positon = 0;
  String text = "Profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 218, 185, 1.0),
      appBar: AppBar(
        // backgroundColor: Colors.orange.shade600,
        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
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
        // backgroundColor: Colors.orange.shade600,
        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
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
      // body:  SwdProfile(emailText:widget.emailText)
      body: displayScreen(positon),
    );
  }
}
