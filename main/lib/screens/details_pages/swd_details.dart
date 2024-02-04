import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsForm extends StatefulWidget {
  const DetailsForm({super.key, required this.emailText});
  final String emailText;
  @override
  // ignore: no_logic_in_create_state
  State<DetailsForm> createState() => _DetailsFormState(emailText);
}

class _DetailsFormState extends State<DetailsForm> {
  _DetailsFormState(this.emailText);
  String emailText;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  var _age = 0;
  var _uid = 0;
  var _contact = '';
  String _disabilityValue = 'Select';
  String _yearValue = 'Select';
  String _courseValue = 'Select';

  // List of items in our dropdown menu
  var disabilityItems = [
    'Select',
    'Visual Impairment',
    'Learning Disability',
    'Other',
  ];

  var yearItems = [
    'Select',
    'FYJC',
    'SYJC',
    'FY',
    'SY',
    'TY',
    'Masters',
  ];

  var courseItems = [
    'Select',
    'Arts',
    'Science',
    'Commerce',
    'BSc',
    'BA',
    'BCom',
    'BSc IT',
    'BMS',
    'BA MCJ',
    'BAF',
    'Other(Masters)',
  ];

  var _validationMessage = "";

  dropDownValidate() {
    setState(() {
      if ((_disabilityValue == 'Select') ||
          (_yearValue == 'Select') ||
          (_courseValue == 'Select')) {
        _validationMessage = "Please Enter Valid Dropdown Option/s";
      } else {
        _validationMessage = "";
      }
    });
  }

  addDetails() {
    CollectionReference colref = FirebaseFirestore.instance.collection('SWD');

    Map<String, dynamic> swdMap = {
      "email": _email.text,
      "name": _name.text,
      "age": _age,
      "uid": _uid,
      "year": _yearValue,
      "course": _courseValue,
      "disability": _disabilityValue,
      "phoneNo": _contact,
    };

    colref
        .doc(_email.text)
        .set(swdMap)
        .then((value) => print("Details Added"))
        .catchError((error) => print("Failed to add details : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Details Form",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(227, 161, 43, 0.3),
            ),
            child: Expanded(
              child: Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Image.asset(
                                        "assets/images/xaviers_logo.png",
                                      ),
                                    ),
                                    const Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text("Welcome Dear Student!",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromRGBO(
                                                      162, 7, 48, 1),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Center(
                                          child: Text(
                                              "You're in the Right Place!",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromRGBO(
                                                      162, 7, 48, 1),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
              
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Basic Details:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(162, 7, 48, 1),
                                      decoration: TextDecoration.underline),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //  Name Field
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                    hintText: "Enter Full Name",
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
                                  controller: _name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //  Age Field
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update _age whenever the text changes
                                    setState(() {
                                      _age = int.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Age';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Please Enter a Valid Age';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter Age",
                                    hintStyle: TextStyle(fontSize: 15),
                                    labelText: "Age",
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(162, 7, 48, 1)),
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
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
              
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Update _uid whenever the text changes
                                    setState(() {
                                      _uid = int.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter UID (Roll No for JC)';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Please Enter a Valid UID / Roll No.';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter UID (Roll No for JC)",
                                    hintStyle: TextStyle(fontSize: 15),
                                    labelText: "UID / Roll No",
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(162, 7, 48, 1)),
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
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
              
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color:
                                            const Color.fromRGBO(77, 77, 77, 1)),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Year: ",
                                        style: TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1),
                                            fontSize: 20),
                                      ),
                                      const SizedBox(width: 190),
                                      DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1)),
                                        value: _yearValue,
                                        icon:
                                            const Icon(Icons.keyboard_arrow_down),
                                        items: yearItems.map((String year_items) {
                                          return DropdownMenuItem(
                                            value: year_items,
                                            child: Text(year_items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) => setState(
                                            () => _yearValue = value.toString()),
                                      ),
                                    ],
                                  ),
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
              
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color:
                                            const Color.fromRGBO(77, 77, 77, 1)),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Course: ",
                                        style: TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1),
                                            fontSize: 20),
                                      ),
                                      const SizedBox(width: 150),
                                      DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1)),
                                        value: _courseValue,
                                        icon:
                                            const Icon(Icons.keyboard_arrow_down),
                                        items: courseItems.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) => setState(
                                            () =>
                                                _courseValue = value.toString()),
                                        //validator: (value) => value == "Select" ? ' Please Select a Valid Option' : null,
                                      ),
                                    ],
                                  ),
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
              
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color:
                                            const Color.fromRGBO(77, 77, 77, 1)),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Type of Disability: ",
                                        style: TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1),
                                            fontSize: 20),
                                      ),
                                      const SizedBox(width: 30),
                                      DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(162, 7, 48, 1)),
                                        value: _disabilityValue,
                                        icon:
                                            const Icon(Icons.keyboard_arrow_down),
                                        items:
                                            disabilityItems.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) => setState(
                                            () => _disabilityValue =
                                                value.toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(_validationMessage,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(162, 7, 48, 1),
                                        fontSize: 12)),
                                const SizedBox(
                                  height: 30,
                                ),
              
                                const Text(
                                  "Contact Details:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(162, 7, 48, 1),
                                      decoration: TextDecoration.underline),
                                ),
              
                                const SizedBox(
                                  height: 20,
                                ),
                                // Email field disabled
                                TextFormField(
                                  controller: _email,
                                  enabled: false,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //  Contact no. Field
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    // Update _age whenever the text changes
                                    setState(() {
                                      _contact = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Phone No';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Please Enter a Valid Phone Number';
                                    }
                                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                      return 'Invalid Phone Number Format';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Phone No",
                                    hintText: "Enter Phone No.",
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
                                ),
              
                                const SizedBox(
                                  height: 30,
                                ),
                                // Submit Form Button
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(162, 7, 48, 1)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () {
                                    dropDownValidate();
                                    if ((_formKey.currentState!.validate() ==
                                            true) &&
                                        (_validationMessage == "")) {
                                      print("'submit' button pressed");
                                      addDetails();
                                    }
                                    // print('name : '+_name.text);
                                  },
                                  child: const Text('SUBMIT'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
            ),
          ));
  }

  @override
  void initState() {
    super.initState();

    _email.text = emailText;
  }
}