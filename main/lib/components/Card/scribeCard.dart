import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:main/screens/home/scribe/scribe_view_requests.dart';
class ScribeCard extends StatefulWidget {
  ScribeCard({super.key, this.data, this.index});
  dynamic index;
  final Map<String,dynamic>? data;
  @override
  State<ScribeCard> createState() => _ScribeCardState();
}

class _ScribeCardState extends State<ScribeCard> {
  var _cardVisible=true;
  // logic for accepting request
  Future<void> acceptRequest(int index) async {
    setState(() {
      widget.data!['data']['status']="accepted";
    });
    
    print("inside accept for $index");
    // dynamic id = listOfRequest[0]['docid'];
    // print('id: $id and data is ${listOfRequest[0]['data']}');
    // final snapshot = await FirebaseFirestore.instance
    //     .collection("SWD")
    //     .doc(listOfRequest[0]['data']['swdId'])
    //     .get();
    //     print(snapshot.data());
    // await FirebaseFirestore.instance
    //     .collection("Requests")
    //     .doc(id)
    //     .update({"status": "accepted"}).then((value) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Thank you")));
    // }).onError((error, stackTrace) {
    //   print('not accepted request');
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Problem!!!")));
    // });
  }

  // logic for declining request
  Future<void> declineRequest(int index) async {
    print("inside decline for $index");
    //dispose();
    // dynamic id = listOfRequest[0]['docid'];
    // Map<String, dynamic> data = listOfRequest[0]['data']['examData'];
    // print('id is $id and data is $data');
    // print(
    //     'examtype - ${data['examType']}, subjectName - ${data['subjectName']}, dateandtime - ${data['dateAndTime']}, swd email id - ${listOfRequest[0]['data']['swdId']}');

    // await FirebaseFirestore.instance
    //     .collection("Requests")
    //     .doc(id)
    //     .delete()
    //     .then((value) {
    //   print('Request declined');
    // }).onError((error, stackTrace) {
    //   print("could not decline request");
    // });

    // try {
    //   await RequestApi().findScribe(data['examType'], data['subjectName'],
    //       data['dateAndTime'], listOfRequest[0]['data']['swdId']);
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Your request is declined'),
    //     action: SnackBarAction(
    //       label: 'OK',
    //       onPressed: () {
    //         // Some code to undo the change.
    //       },
    //     ),
    //   ));
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Not declined'),
    //     action: SnackBarAction(
    //       label: 'OK',
    //       onPressed: () {
    //         // Some code to undo the change.
    //       },
    //     ),
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:_cardVisible,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5, right: 15, left: 15),
        child: Expanded(
          child: Card(
            color: widget.data!['data']['status']!="accepted"?Colors.white:const Color.fromRGBO(191, 255, 215, 0.7),
            child: Container(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 5),
              width: 400,
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 260,
                        child: Column(
                          children: [
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
                            const SizedBox(height:10),
                            Visibility(
                              visible:widget.data!['data']['status']!="accepted",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: (){
                                      print("Accept pressed");
                                        acceptRequest(widget.index);
                                    },
                                    child: const Text(
                                      "ACCEPT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                              
                                  const SizedBox(width:10),
                              
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: (){
                                      declineRequest(widget.index);
                                      setState(() {
                                        _cardVisible=false;
                                      });
                                    },
                                    child: const Text(
                                      "DECLINE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: widget.data!['data']['status']=="accepted",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ACCEPTED",
                                    style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.data!['data']['status'] != "pending",
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        TextButton(
                          child: Text(
                            "Details",
                            style: TextStyle(color: Colors.blue.shade500, fontSize: 15),
                          ),
                          onPressed: () async {
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
                                            "SWD DETAILS",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Student Name: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                          Text(
                                            "Contact No: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                          Text(
                                            "Email ID: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                          Text(
                                            "UID: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                          Text(
                                            "Year: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                          Text(
                                            "Course: ${widget.data!['data']['swdData']}",
                                            style: const TextStyle(fontSize: 15, color: Colors.white)
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

