import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/requestApi.dart';

class ViewSwdRequests extends StatefulWidget {
  const ViewSwdRequests({super.key, this.email});
  final String? email;

  @override
  State<ViewSwdRequests> createState() => _ViewSwdRequestsState();
}

class _ViewSwdRequestsState extends State<ViewSwdRequests> {
  List<Map<String, dynamic>> listOfRequest = [];
  Future<void> getRequests() async {
    print("\n scribe email id: ${widget.email.toString()}");
    print('\n');
    await FirebaseFirestore.instance
        .collection("Requests")
        .where("scribeId", isEqualTo: widget.email.toString())
        .get()
        .then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> documents = snapshot.docs;
      for (QueryDocumentSnapshot doc in documents) {
        print(doc.data());
        final data = {'docid': doc.id, 'data': doc.data()};
        listOfRequest.add(data);
      }
      print(
          "\n\n list of requests is as follows with length ${listOfRequest.length}");
      print('\n $listOfRequest');
    }).onError((error, stackTrace) {
      print("Error displayed while getting requests of scribe");
    });
  }

  // logic for accepting request
  Future<void> acceptRequest() async {
    dynamic id = listOfRequest[0]['docid'];
    print('id: $id and data is ${listOfRequest[0]['data']}');
    final snapshot = await FirebaseFirestore.instance
        .collection("SWD")
        .doc(listOfRequest[0]['data']['swdId'])
        .get();
        print(snapshot.data());
    await FirebaseFirestore.instance
        .collection("Requests")
        .doc(id)
        .update({"status": "accepted"}).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Thank you")));
    }).onError((error, stackTrace) {
      print('not accepted request');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Problem!!!")));
    });
  }

  // logic for declining request
  Future<void> declineRequest() async {
    dynamic id = listOfRequest[0]['docid'];
    Map<String, dynamic> data = listOfRequest[0]['data']['examData'];
    print('id is $id and data is $data');
    print(
        'examtype - ${data['examType']}, subjectName - ${data['subjectName']}, dateandtime - ${data['dateAndTime']}, swd email id - ${listOfRequest[0]['data']['swdId']}');

    await FirebaseFirestore.instance
        .collection("Requests")
        .doc(id)
        .delete()
        .then((value) {
      print('Request declined');
    }).onError((error, stackTrace) {
      print("could not decline request");
    });

    try {
      await RequestApi().findScribe(data['examType'], data['subjectName'],
          data['dateAndTime'], listOfRequest[0]['data']['swdId']);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Your request is declined'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Not declined'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text("Your requests from SWD...."),
        ),
        ElevatedButton(
            onPressed: acceptRequest, child: const Text("accept request")),
        ElevatedButton(
            onPressed: declineRequest, child: const Text("decline request"))
      ],
    );
  }
}
