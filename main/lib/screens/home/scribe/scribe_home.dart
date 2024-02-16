import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/login/login_screen.dart';

class ScribeHome extends StatefulWidget {
  final String? emailText;
  const ScribeHome({super.key, required this.emailText});

  @override
  State<ScribeHome> createState() => _ScribeHomeState();
}

class _ScribeHomeState extends State<ScribeHome> {
  final TextStyle customTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
        child: Text(
          "hello SWD ${widget.emailText}",
          style: customTextStyle.copyWith(
            fontSize: 15,
          ),
        ),
      ),
      FloatingActionButton.extended(onPressed: (){
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const LoginScreen()));
        })
        .onError((error, stackTrace) {print("logout fail");});
      },label: const Text("Logout"),),
        ],
      ),
    );
  }
}
