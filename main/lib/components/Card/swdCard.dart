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
  String status = "pending";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, right: 15, left: 15),
      child: Card(
        // color: status == "pending" ? Colors.yellow : Colors.green.shade100,
        child: Container(
            padding: const EdgeInsets.only(right:0, left: 15, top:15, bottom:5),
            width: 320,
            height: 100,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status: $status"),
                    Text(
                      "Pending",
                      style: TextStyle(
                          fontSize: 25, color: Colors.amber.shade400),
                    ), 
                  ],
                ),
                const SizedBox(width: 150),
                const Column(
                  children: [
                    SizedBox(height: 55),
                    Text(
                    "Details",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ],
            ),
            ),
      ),
    );
  }
}
