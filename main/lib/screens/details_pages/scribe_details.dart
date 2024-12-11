import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main/components/Input/Dropdown.dart';
import 'package:main/screens/home/scribe/scribe_home.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class scribeswdDetailsForm extends StatefulWidget {
   scribeswdDetailsForm(
      {super.key,
      required this.emailText,
      this.currentName,
      this.currentAge,
      this.currentUid,
      this.currentCourse,
      this.currentYear,
      this.currentPhone,
      this.currentCollegeName,
      this.currentCentres});
  final String emailText;
  final String? currentName, currentAge, currentUid, currentYear, currentCourse,currentPhone, currentCollegeName;
  List<String>? currentCentres;
  @override
  // ignore: no_logic_in_create_state
  State<scribeswdDetailsForm> createState() => _swdDetailsFormState2(emailText);
}

class _swdDetailsFormState2 extends State<scribeswdDetailsForm> {
  _swdDetailsFormState2(this.emailText);
  String emailText;
  // bool enabled = false;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final __age = TextEditingController();
  final __uid = TextEditingController();
  final phoneController = TextEditingController();
  final college_controller = MultiSelectController<String>();
  var _age = 0;
  var _uid = 0;
  var _contact = '';
  String _yearValue = 'Select';
  String _courseValue = 'Select';
  String imageUrl = "";
  bool uploadStatus = false;
  // List of items in our dropdown menus
  var yearItems = [
    'Select',
    'FYJC',
    'SYJC',
    'FY',
    'SY',
    'TY',
  ];
  String uploadLabel = "Add Profile pic";
  var courseItems1 = [
    'Select',
    'BSc',
    'BA',
    'BCom',
    'BSc IT',
    'BMS',
    'BA MCJ',
    'BAF',
  ];
  var courseItems2 = [
    'Select',
    'Arts',
    'Science',
    'Commerce',
  ];

  var collegeItems = [
    DropdownItem(label: 'St. Xaviers', value: 'St. Xaviers'),
    DropdownItem(label: 'KC', value: 'KC'),
    DropdownItem(label: 'SIES', value: 'SIES'),
    DropdownItem(label: 'ST. ANDREWS', value: 'ST. ANDREWS')
  ];

  var centresList = [];

  var _validationMessage = "";

  var collegeName = "SELECT";

  void getCollegeName(college) {
    setState(() {
      collegeName = college;
    });
    print("College selected " + collegeName);
  }

  dropDownValidate() {
    setState(() {
      if ((_yearValue == 'Select') || (_courseValue == 'Select')) {
        _validationMessage = "Please Enter Valid Dropdown Option/s";
      } else {
        _validationMessage = "";
      }
    });
  }

  addDetails() {
    CollectionReference colref =
        FirebaseFirestore.instance.collection('Scribes');

    Map<String, dynamic> scribesMap = {
      "email": _email.text.toLowerCase(),
      "name": _name.text,
      "age": _age,
      "uid": _uid,
      "year": _yearValue,
      "course": _courseValue,
      "phoneNo": _contact.toLowerCase(),
      "imageUrl": imageUrl,
      "collegeName": collegeName,
      "centres": centresList
    };
    print("Scribe Details: $scribesMap");
    colref.doc(_email.text).set(scribesMap).then((value) {
      print("Details Added");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => ScribeHome(emailText: emailText)));
    }).onError((error, stackTrace) {
      print("Cannot Go from from details to home due to ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(
                                //   height: 100,
                                //   child: Image.asset(
                                //     "assets/images/xaviers_logo.png",
                                //   ),
                                // ),

                                Flexible(
                                  child: Center(
                                    child: Text(
                                        "Welcome Dear Scribe! Your contribution is greatly valued",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color:
                                                Color.fromRGBO(162, 7, 48, 1),
                                            fontWeight: FontWeight.bold)),
                                  ),
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
                              decoration: InputDecoration(
                                labelText: "Name",
                                hintText: "Enter Full Name",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(71, 71, 71, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                              controller: __age,
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
                              decoration: InputDecoration(
                                hintText: "Enter Age",
                                hintStyle: TextStyle(fontSize: 15),
                                labelText: "Age",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(71, 71, 71, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                              controller: __uid,
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
                              decoration: InputDecoration(
                                hintText: "Enter UID (Roll No for JC)",
                                hintStyle: TextStyle(fontSize: 15),
                                labelText: "UID / Roll No",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(71, 71, 71, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromRGBO(77, 77, 77, 1)),
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
                                  DropdownButton<String>(
                                    dropdownColor: Colors.white,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(162, 7, 48, 1)),
                                    value: _yearValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: yearItems.map((String yearItem) {
                                      return DropdownMenuItem(
                                        value: yearItem,
                                        child: Text(yearItem),
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromRGBO(77, 77, 77, 1)),
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
                                  DropdownButton<String>(
                                    dropdownColor: Colors.white,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(162, 7, 48, 1)),
                                    value: _courseValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: _yearValue == "FYJC" ||
                                            _yearValue == "SYJC"
                                        ? courseItems2.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList()
                                        : courseItems1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                    onChanged: (String? value) => setState(
                                        () => _courseValue = value.toString()),
                                    //validator: (value) => value == "Select" ? ' Please Select a Valid Option' : null,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton.extended(
                                    backgroundColor:
                                        const Color.fromRGBO(162, 7, 48, 1),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                FloatingActionButton.extended(
                                                  onPressed: () async {
                                                    setState(() {
                                                      uploadStatus = true;
                                                      print(
                                                          "tapped on camera button");
                                                    });

                                                    ImagePicker imgPicker =
                                                        ImagePicker();
                                                    XFile? file = await imgPicker
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (file == null) {
                                                      print("No file found ");
                                                      setState(() {
                                                        uploadStatus = false;
                                                      });
                                                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kindly upload a photo")));
                                                      return;
                                                    }
                                                    print(
                                                        "Image path: ${file.path}");
                                                    //step 1 completed

                                                    //step 2
                                                    // create a unique id
                                                    String uniqueFileName =
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString();

                                                    // Get a reference to storage root
                                                    Reference refRoot =
                                                        FirebaseStorage.instance
                                                            .ref();

                                                    // If needed mention the exact folder where it has to stored
                                                    Reference refDirImages =
                                                        refRoot
                                                            .child("profiles");

                                                    //Create a reference to that image which needs to be stored
                                                    // Reference refImageToBeUploaded = refDirImages.child("${file?.name}");
                                                    Reference
                                                        refImageToBeUploaded =
                                                        refDirImages.child(
                                                            uniqueFileName);

                                                    //store the file to that reference
                                                    try {
                                                      await refImageToBeUploaded
                                                          .putFile(
                                                              File(file.path));

                                                      //get the download url (step 3)

                                                      imageUrl =
                                                          await refImageToBeUploaded
                                                              .getDownloadURL();
                                                      setState(() {
                                                        uploadLabel =
                                                            "Uploaded Profile pic";
                                                      });
                                                      print(
                                                          "Image url: $imageUrl");
                                                    } on FirebaseException catch (err) {
                                                      print(err.message
                                                          .toString());
                                                      setState(() {
                                                        uploadLabel =
                                                            "No Profile pic";
                                                      });
                                                    } catch (e) {
                                                      setState(() {
                                                        uploadLabel =
                                                            "No Profile pic";
                                                      });
                                                      print(
                                                          "File was not uploaded due to ${e.toString()}");
                                                    } finally {
                                                      // Hide the loading indicator
                                                      setState(() {
                                                        uploadStatus = false;
                                                      });
                                                    }
                                                  },
                                                  label: const Text("Camera"),
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                FloatingActionButton.extended(
                                                  onPressed: () async {
                                                    setState(() {
                                                      uploadStatus = true;
                                                    });
                                                    print("Gallery ");
                                                    ImagePicker imgPicker =
                                                        ImagePicker();
                                                    XFile? file = await imgPicker
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    if (file == null) {
                                                      print("No file found ");
                                                      setState(() {
                                                        uploadStatus = false;
                                                      });
                                                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kindly upload a photo")));
                                                      return;
                                                    }
                                                    print(
                                                        "Image path: ${file.path}");
                                                    //step 1 completed

                                                    //step 2
                                                    // create a unique id
                                                    String uniqueFileName =
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString();

                                                    // Get a reference to storage root
                                                    Reference refRoot =
                                                        FirebaseStorage.instance
                                                            .ref();

                                                    // If needed mention the exact folder where it has to stored
                                                    Reference refDirImages =
                                                        refRoot
                                                            .child("profiles");

                                                    //Create a reference to that image which needs to be stored
                                                    // Reference refImageToBeUploaded = refDirImages.child("${file?.name}");
                                                    Reference
                                                        refImageToBeUploaded =
                                                        refDirImages.child(
                                                            uniqueFileName);

                                                    //store the file to that reference
                                                    try {
                                                      await refImageToBeUploaded
                                                          .putFile(
                                                              File(file.path));

                                                      //get the download url (step 3)

                                                      imageUrl =
                                                          await refImageToBeUploaded
                                                              .getDownloadURL();
                                                      print(
                                                          "Image url: $imageUrl");
                                                    } on FirebaseException catch (err) {
                                                      print(err.message
                                                          .toString());
                                                    } catch (e) {
                                                      print(
                                                          "File was not uploaded due to ${e.toString()}");
                                                    } finally {
                                                      setState(() {
                                                        uploadStatus = false;
                                                      });
                                                    }
                                                  },
                                                  label: const Text("Gallery"),
                                                  icon: const Icon(Icons.photo),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    label: !uploadStatus
                                        ? Text(
                                            uploadLabel,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const CircularProgressIndicator(),
                                  )
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
                              height: 15,
                            ),

                            const Text(
                              "College Details",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(162, 7, 48, 1),
                                  decoration: TextDecoration.underline),
                            ),

                            Dropdown(onSelected: getCollegeName,defaultOption: collegeName,),

                            Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: MultiDropdown<String>(
                                items: collegeItems,
                                controller: college_controller,
                                enabled: true,
                                searchEnabled: true,
                                chipDecoration: const ChipDecoration(
                                  backgroundColor: Colors.yellow,
                                  wrap: true,
                                  runSpacing: 2,
                                  spacing: 10,
                                ),
                                fieldDecoration: FieldDecoration(
                                  hintText: 'Colleges',
                                  hintStyle:
                                      const TextStyle(color: Colors.black87),
                                  prefixIcon: const Icon(Icons.flag),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                dropdownDecoration: const DropdownDecoration(
                                  marginTop: 2,
                                  maxHeight: 500,
                                  header: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Select Colleges from the list',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  selectedIcon: const Icon(Icons.check_box,
                                      color: Colors.green),
                                  disabledIcon: Icon(Icons.lock,
                                      color: Colors.grey.shade300),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a college';
                                  }
                                  return null;
                                },
                                onSelectionChange: (selectedItems) {
                                  setState(() {
                                    centresList = selectedItems;
                                  });
                                  debugPrint(
                                      "OnSelectionChange: $selectedItems");
                                },
                              ),
                            ),

                            const SizedBox(
                              height: 20,
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
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                                filled: true,
                                fillColor: Colors.white,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                              controller: phoneController,
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
                              decoration: InputDecoration(
                                labelText: "Phone No",
                                hintText: "Enter Phone No.",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(162, 7, 48, 1)),
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(71, 71, 71, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromRGBO(162, 7, 48, 1)),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              onPressed: () {
                                if (uploadStatus) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(
                                                "Your profile photo is yet to be uploaded"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                  return;
                                }
                                dropDownValidate();
                                if (collegeName == 'SELECT') {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(
                                                "Do select your institute name"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                  return;
                                }
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
              ]),
        ));
  }

  @override
  void initState() {
    super.initState();

    _email.text = emailText;
    if (widget.currentName != null) {
      _name.text = widget.currentName.toString();
    }
    if (widget.currentAge != null) {
      __age.text = widget.currentAge.toString();
      setState(() {
        _age = int.parse(widget.currentAge.toString());
      });
    }

    if (widget.currentUid != null) {
      __uid.text = widget.currentUid.toString();
      setState(() {
        _uid = int.parse(widget.currentUid.toString());
      });
    }

    if (widget.currentYear != null) {
      _yearValue = widget.currentYear.toString();
    }

    if (widget.currentCourse != null) {
      _courseValue = widget.currentCourse.toString();
    }

    if (widget.currentPhone != null) {
      _contact = widget.currentPhone.toString();
      phoneController.text = widget.currentPhone.toString();
    }

    if (widget.currentCollegeName != null) {
      setState(() {
        
      collegeName = widget.currentCollegeName.toString();
      });
    }

    
  }
}
