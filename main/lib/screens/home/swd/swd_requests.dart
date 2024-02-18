import 'package:flutter/material.dart';

class SwdRequests extends StatefulWidget {
  const SwdRequests({super.key});

  @override
  State<SwdRequests> createState() => _SwdRequestsState();
}

class _SwdRequestsState extends State<SwdRequests> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Your requests"),);
  }
}