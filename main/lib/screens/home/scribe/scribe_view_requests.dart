import 'package:flutter/cupertino.dart';

class ViewSwdRequests extends StatefulWidget {
  const ViewSwdRequests({super.key});

  @override
  State<ViewSwdRequests> createState() => _ViewSwdRequestsState();
}

class _ViewSwdRequestsState extends State<ViewSwdRequests> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Your requests from SWD...."),
    );
  }
}