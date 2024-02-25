import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/components/Card/scribeCard.dart';

import '../../../api/requestApi.dart';

class ViewSwdRequests extends StatefulWidget {
  const ViewSwdRequests({super.key, this.email});
  final String? email;

  @override
  State<ViewSwdRequests> createState() => _ViewSwdRequestsState();
}

class _ViewSwdRequestsState extends State<ViewSwdRequests> {
  List<Map<String, dynamic>> listOfRequest =[];
    // {
    //   "docid":123456,
    //   "data":{
    //     "scribeId": "isha",
    //     "swdData": "abc",
    //     "status": "accepted"
    //   },
    //   "examData":{
    //     'dateAndTime':"12th Feb 9 am",
    //     "examType":"CIA 1",
    //     "subjectName":"History",
    //   }
    // },
    // {
    //   "docid":123456,
    //   "data":{
    //     "scribeId": "isha",
    //     "swdData": "abc",
    //     "status": "pending"
    //   },
    //   "examData":{
    //     'dateAndTime':"12th Feb 9 am",
    //     "examType":"CIA 1",
    //     "subjectName":"Geography",
    //   }
    // },
    // {
    //   "docid":123456,
    //   "data":{
    //     "scribeId": "isha",
    //     "swdData": "abc",
    //     "status": "pending"
    //   },
    //   "examData":{
    //     'dateAndTime':"12th Feb 9 am",
    //     "examType":"CIA 1",
    //     "subjectName":"Math",
    //   }
    // },
    // {
    //   "docid":123456,
    //   "data":{
    //     "scribeId": "isha",
    //     "swdData": "abc",
    //     "status": "pending"
    //   },
    //   "examData":{
    //     'dateAndTime':"12th Feb 9 am",
    //     "examType":"CIA 1",
    //     "subjectName":"English",
    //   }
    // },
  
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

  
  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children:[
          listOfRequest==[]?
          const Center(child: Text("No Requests")):
          Column(
            children: List.generate(listOfRequest.length, (index) {
              return ScribeCard(data:listOfRequest[index], index: index);
            }),
          ),
        ],
      ),
    );
      
    
    
     
    // return Column(
    //   children: [
    //     const Center(
    //       child: Text("Your requests from SWD...."),
    //     ),
    //     ElevatedButton(
    //         onPressed: acceptRequest, child: const Text("accept request")),
    //     ElevatedButton(
    //         onPressed: declineRequest, child: const Text("decline request"))
    //   ],
    // );
  }
}
