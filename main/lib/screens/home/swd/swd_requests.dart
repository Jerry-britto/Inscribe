import 'package:flutter/material.dart';
import 'package:main/components/Card/swdCard.dart';

class SwdRequests extends StatefulWidget {
  const SwdRequests({super.key});

  @override
  State<SwdRequests> createState() => _SwdRequestsState();
}

class _SwdRequestsState extends State<SwdRequests> {
  dynamic data;
  @override
  void initState() {
    // call when retrieving data from swd db
    super.initState();
    setState(() {
    data = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SwdCard(data:null),
        //SwdCard(data:null),
      ],
    );
  //   if (data==[] && data == null) {
  //     return const Center(child: Text("No Requests"));
  //   } else {
  //     return SwdCard(data: data);
  //   }
   }
}
