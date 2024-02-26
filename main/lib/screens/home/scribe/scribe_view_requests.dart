import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/components/Card/scribeCard.dart';

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
        setState(() {
          listOfRequest.add(data);
        });
      }
      print(
          "\n\n list of requests is as follows with length ${listOfRequest.length}");
      print('\n $listOfRequest\n\n');
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
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            listOfRequest.clear();
          });
          await getRequests();
        },
        child: listOfRequest == [] || listOfRequest.isEmpty
            ? const Center(child: Text("No Requests"))
            : ListView(
                children: [
                  Column(
                    children: List.generate(listOfRequest.length, (index) {
                      return ScribeCard(
                          data: listOfRequest[index], index: index);
                    }),
                  ),
                ],
              ),
      ),
    );

    // return Column(
    //   children: [
    //     const Center(
    //       child: Text("Your requests from SWD...."),
    //     ),
    //     ElevatedButton(
    //         onPressed: (){}, child: const Text("accept request")),
    //     ElevatedButton(
    //         onPressed: (){}, child: const Text("decline request"))
    //   ],
    // );
  }
}
