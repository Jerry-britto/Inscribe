import 'package:flutter/material.dart';

class SwdCard extends StatefulWidget {
  const SwdCard({super.key, this.data});
  final dynamic data;

  /*
  data will consist of the following things:-
  1. scribe id (email id)
  2. status
  3. subject name
  4. date and time of exam
  5. type of exam with duration

  structure - List<Map<String,dyanmic>> of map
  widget.data gets the data from the parent class
  request=[
    {
    'scribeId':___
    'status':___
    'subjectName': ___
    'date and time':____
  },
  {
    'scribeId':___
    'status':___
    'subjectName': ___
    'date and time':____
  },
  {
    'scribeId':___
    'status':___
    'subjectName': ___
    'date and time':____
  },
  ]
  
  */
  @override
  State<SwdCard> createState() => _SwdCardState();
}

class _SwdCardState extends State<SwdCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("swd card"),
    );
  }
}
