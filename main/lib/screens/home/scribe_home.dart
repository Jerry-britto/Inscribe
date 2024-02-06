import 'package:flutter/material.dart';

class ScribeHome extends StatefulWidget {
  final String? emailText;
  const ScribeHome({super.key, required this.emailText});

  @override
  State<ScribeHome> createState() => _ScribeHomeState();
}

class _ScribeHomeState extends State<ScribeHome> {
  final TextStyle customTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Hello Scribe ${widget.emailText}",
        style: customTextStyle.copyWith(
          fontSize: 15,
        ),
      ),
    );
  }
}
