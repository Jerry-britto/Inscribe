import 'package:flutter/material.dart';
import 'package:main/components/Card/swdCard.dart';

class SwdRequests extends StatefulWidget {
  const SwdRequests({super.key});

  @override
  State<SwdRequests> createState() => _SwdRequestsState();
}

class _SwdRequestsState extends State<SwdRequests> {
  dynamic data;
    List<Map<String,dynamic>>request=[
    {
      'scribeId':null,
      'status':"pending",
      "examData":{
        'dateAndTime':"12th Feb 9 am",
        "examType":"CIA 1",
        "subjectName":"History",
      },
    },
    {
      'scribeId':null,
      'status':"pending",
      "examData":{
        'dateAndTime':"12th Feb 9 am",
        "examType":"CIA 1",
        "subjectName":"History",
      },
    },
    {
      'scribeId':"sahil",
      'status':"accepted",
      "examData":{
        'dateAndTime':"12th Feb 9 am",
        "examType":"CIA 1",
        "subjectName":"History",
      },
    },
    {
      'scribeId':"jerry",
      'status':"accepted",
      "examData":{
        'dateAndTime':"12th Feb 9 am",
        "examType":"CIA 1",
        "subjectName":"History",
      },
    },
    {
      'scribeId':"isha",
      'status':"accepted",
      "examData":{
        'dateAndTime':"12th Feb 9 am",
        "examType":"CIA 1",
        "subjectName":"History",
      },
    },
  ];
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
    if(data==null)
    {
      return const Center(child:Text("No Requests"));
    }
    return SingleChildScrollView(
      child: Column(
        children: List.generate(request.length, (index) {
          return SwdCard(data:request[index]);
        })
      ),
    );
    
   }
}
