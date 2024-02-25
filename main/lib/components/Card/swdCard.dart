import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SwdCard extends StatefulWidget {
  const SwdCard({super.key, this.data});
  final Map<String, dynamic>? data;
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
  Map<String, dynamic>? scribeData;
  Future<void> getScribeData(String scribeId) async {
    print(scribeId);
    final snapshot = await FirebaseFirestore.instance
        .collection("Scribes")
        .doc(scribeId)
        .get();
    final data = snapshot.data();
    print(data);
    setState(() {
      scribeData = data;
    });
  }

  String status = "pending";
  dynamic color1;
  dynamic statusIcon;
  @override
  void initState() {
    status = widget.data!['status'];
    super.initState();
    if (status == "pending") {
      setState(() {
        color1 = Colors.amber.shade800;
        statusIcon = Icon(Icons.pending, color: color1, size: 82);
      });
    } else {
      setState(() {
        color1 = Colors.green;
        statusIcon = Icon(Icons.check_circle, color: color1, size: 82);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, right: 15, left: 15),
      child: Expanded(
        child: Card(
          child: Container(
            padding:
                const EdgeInsets.only(right: 0, left: 15, top: 15, bottom: 5),
            width: 400,
            height: 170,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: 250,
                      child: Column(
                        children: [
                          Text("Status: $status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: color1)),
                          const SizedBox(height: 10),
                          Text(
                            'Subject: ${widget.data!['examData']['subjectName']}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Type of Exam: ${widget.data!['examData']['examType']}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Text(
                            'Date and Time:',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '${widget.data!['examData']['dateAndTime']}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    statusIcon,
                    Visibility(
                      visible: widget.data!['status'] != "pending",
                      child: TextButton(
                        child: const Text(
                          "Details",
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                        onPressed: () async {
                          await getScribeData(widget.data!['scribeId']);

                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromRGBO(162, 7, 48, 1),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  height: 250,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "SCRIBE DETAILS",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Scribe Name: ${scribeData!['name']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                        Text(
                                          "Contact No: ${scribeData!['phoneNo']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                        Text(
                                          "Email ID: ${scribeData!['email']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                        Text(
                                          "UID: ${scribeData!['uid']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                        Text(
                                          "Year: ${scribeData!['year']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                        Text(
                                          "Course: ${scribeData!['course']}",
                                          style: const TextStyle(fontSize: 15, color: Colors.white)
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
