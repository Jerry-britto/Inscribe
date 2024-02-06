import 'package:flutter/material.dart';

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
    return Center(
      child: Text(
        "hello SWD ${widget.emailText}",
        style: customTextStyle.copyWith(
          fontSize: 15,
        ),
      ),
    );
  }
}