import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SwdRequests extends StatefulWidget {
  const SwdRequests({super.key, this.email});
  final String? email;

  @override
  State<SwdRequests> createState() => _SwdRequestsState();
}

class _SwdRequestsState extends State<SwdRequests> {
  List<Map<String,dynamic>> listOfRequests = [];
  Future<void> getRequests() async {
    print("\nDisplaying requests\n\n");
    await FirebaseFirestore.instance
        .collection("Requests")
        .where("swdId", isEqualTo: widget.email!.toString())
        .get()
        .then((QuerySnapshot querySnapshot) {
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            for(QueryDocumentSnapshot doc in documents){
              print(doc.data());
              final data = doc.data();
              listOfRequests.add(data as Map<String,dynamic>);
            }
          print('\n Displaying list of requests of length ${listOfRequests.length}:- \n');
          print(listOfRequests);
        }).onError((error, stackTrace) {
          print("Error occured while getting requests");
        });
  }
  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Your requests"),
    );
  }
}
