import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    // title: 'User Details',
    debugShowCheckedModeBanner: false,
    home: Details_Form(),
  ));
}

class Details_Form extends StatefulWidget {
  const Details_Form({super.key});

  @override
  State<Details_Form> createState() => _Details_FormState();
}

class _Details_FormState extends State<Details_Form> {
  // bool enabled = false;
  var _formKey = GlobalKey<FormState>();
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _age = '';
  var _contact = '';
  var _disability = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Scribe Details'),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 5,
                          ),
                          //  Name Field
                          TextFormField(
                            controller: _name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Name",
                                hintText: "Enter full name",
                                labelStyle: TextStyle(fontSize: 20),
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //     color: Colors.green,
                                  //     width: 4,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                )),
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
                                _age = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter age';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Age",
                                hintText: "Enter age",
                                labelStyle: TextStyle(fontSize: 20),
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //     color: Colors.green,
                                  //     width: 4,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Email field disabled
                          TextFormField(
                            controller: _email,
                            enabled: false,
                            // readOnly: true,
                            decoration: const InputDecoration(
                                labelText: "Email",
                                // hintText: "Enter age",
                                labelStyle: TextStyle(fontSize: 20),
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //     color: Colors.green,
                                  //     width: 4,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                )),
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
                                return 'Please enter phone no';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Invalid phone number format';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Phone no",
                                hintText: "Enter phone no.",
                                labelStyle: TextStyle(fontSize: 20),
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //     color: Colors.green,
                                  //     width: 4,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Disability type field
                          TextFormField(
                            controller: _disability,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter disability type';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Disability Type",
                                hintText: "Enter disability type",
                                labelStyle: TextStyle(fontSize: 20),
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //     color: Colors.green,
                                  //     width: 4,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Submit Form Button
                          ElevatedButton(
                            child: Text('SUBMIT'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate() == true) {
                                print("'submit' button pressed");
                                print('Name : ${_name.text}');
                                print('Age : ${_age.characters}');
                                print('Phone no : ${_contact.characters}');
                                print('Disability Type : ${_disability.text}');
                              }
                              // print('name : '+_name.text);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ])),
    );
  }
}
