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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
