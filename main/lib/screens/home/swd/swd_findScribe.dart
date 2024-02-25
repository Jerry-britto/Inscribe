import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:main/api/requestApi.dart';

class FindScribe extends StatefulWidget {
  const FindScribe({super.key, this.email});
  final String? email;

  @override
  State<FindScribe> createState() => _FindScribeState();
}

class _FindScribeState extends State<FindScribe> {
  int? selectedOption = 1;
  final _subName = TextEditingController();
  DateTime? selectedDate;
  final _duration = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String examType = "";
  Map<String, dynamic>? SwdData;
  final db = FirebaseFirestore.instance;


  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if ((selectedOption == 1) || (selectedOption == 2)) {
      _duration.text = "45";
    } else if (selectedOption == 3) {
      _duration.text = "120";
    }
  }

  @override
  void initState() {
    super.initState();
    _duration.text = "45";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Type of Exam:",
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.left,
                              ),
                              ListTile(
                                title: const Text('CIA 1',
                                    style: TextStyle(color: Colors.black)),
                                leading: Radio(
                                  activeColor:
                                      const Color.fromRGBO(162, 7, 48, 1),
                                  value: 1,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('CIA 2',
                                    style: TextStyle(color: Colors.black)),
                                leading: Radio(
                                  activeColor:
                                      const Color.fromRGBO(162, 7, 48, 1),
                                  value: 2,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('END SEMESTER',
                                    style: TextStyle(color: Colors.black)),
                                leading: Radio(
                                  activeColor:
                                      const Color.fromRGBO(162, 7, 48, 1),
                                  value: 3,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Enter Exam Details:",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Subject Name",
                              hintText: "Enter Subject Name",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(162, 7, 48, 1)),
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(71, 71, 71, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                              ),
                            ),
                            controller: _subName,
                            validator: (value) {
                              if (_subName.text == "") {
                                return 'Please Enter Subject Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          DateTimeFormField(
                            validator: (value) {
                              if (selectedDate == null) {
                                return 'Please Select Date and Time of the Exam';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Date and Time',
                              hintText: "Enter Date and Time",
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Color.fromRGBO(162, 7, 48, 1),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(162, 7, 48, 1)),
                              hintStyle: TextStyle(fontSize: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(71, 71, 71, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                              ),
                            ),
                            firstDate:
                                DateTime.now().add(const Duration(days: 2)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            //initialPickerDateTime: DateTime.now().add(const Duration(days: 0)),
                            onChanged: (DateTime? value) {
                              selectedDate = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _duration,
                            enabled: false,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: "Duration (in minutes)",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(162, 7, 48, 1)),
                              filled: true,
                              fillColor: Colors.white,
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(71, 71, 71, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(162, 7, 48, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      // await getData();
                      if ((_formKey.currentState!.validate() == true)) {
                        print(selectedDate);
                        print(_subName.text);
                        setState(() {
                          switch (selectedOption) {
                            case 1:
                              print("CIA 1");
                              examType = "CIA 1";
                              break;
                            case 2:
                              print("CIA 2");
                              examType = "CIA 2";
                              break;
                            case 3:
                              examType = "END SEMESTER";
                              print("End semester");
                              break;
                            default:
                              print("Invalid option");
                          }
                        });
                        print("Button pressed");
                        // findScribe(
                        // examType, _subName.text, selectedDate.toString());
                        try {
                          await RequestApi().findScribe(examType, _subName.text,
                              selectedDate.toString(), widget.email.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Request Sent Successfully!'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          ));
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                'No scribe found which meets the requirements'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          ));
                        }
                      }
                    },
                    child: const Text('SEND REQUEST'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
