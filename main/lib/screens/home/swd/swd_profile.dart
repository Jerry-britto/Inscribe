import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/details_pages/swd_details.dart';

class SwdProfile extends StatefulWidget {
  final String? emailText;
  const SwdProfile({super.key, required this.emailText});

  @override
  State<SwdProfile> createState() => _SwdProfileState();
}

class _SwdProfileState extends State<SwdProfile> {
  final TextStyle customTextStyle = const TextStyle(
    fontSize: 20,
  );
  Map<String, dynamic>? data;
  void getData() async {
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection("SWD")
          .doc(widget.emailText)
          .get();
      print(snapShot.data());
      setState(() {
        data = snapShot.data();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print("User Entered ${widget.emailText}");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.white,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data?["name"],
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            data!.containsKey("imageUrl") && data!["imageUrl"]!="" ?data!["imageUrl"]:
                              "https://images.pexels.com/photos/17604370/pexels-photo-17604370/free-photo-of-beautiful-woman-sitting-under-a-tree.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Category :",
                          style: customTextStyle,
                        ),
                        Text(
                          " SWD",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Disability :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data?['disability']}",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Email :",
                        style: customTextStyle,
                      ),
                      Text(
                        " ${data!['email']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ]),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "UID :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data!['uid'].toString()}",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Year :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data!['year']}",
                          style: customTextStyle,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Course :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data!['course']}",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Age :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data!['age'].toString()}",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Contact :",
                          style: customTextStyle,
                        ),
                        Text(
                          " ${data!['phoneNo'].toString()}",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(162, 7, 48, 1),
                          child: IconButton(
                              iconSize: 32,
                              color: Colors.white,
                              onPressed: () {
                                print("edit details");
                                print(data);
                                Future.delayed(const Duration(milliseconds: 1000),(){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsForm(emailText: widget.emailText.toString())));
                                });
                                // print();
                              },
                              icon: Image.asset(
                                "assets/icons/pencil.png",
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
