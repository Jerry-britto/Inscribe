import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main/screens/home/swd/swd_home.dart';

import '../../components/Input/Dropdown.dart';

class swdDetailsForm extends StatefulWidget {
  const swdDetailsForm(
      {super.key,
      required this.emailText,
      this.currentName,
      this.currentDisability,
      this.currentUid,
      this.currentYear,
      this.currentCourse,
      this.currentAge,
      this.currentContact,
      this.currentCollegeName,
      this.currentProfilePhoto});

  final String emailText;

  final String? currentDisability,
      currentUid,
      currentYear,
      currentCourse,
      currentContact,
      currentName,
      currentProfilePhoto,
      currentCollegeName;

  final int? currentAge;

  @override
  // ignore: no_logic_in_create_state
  State<swdDetailsForm> createState() => _swdDetailsFormState(emailText);
}

class _swdDetailsFormState extends State<swdDetailsForm> {
  _swdDetailsFormState(this.emailText);
  String emailText;
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _disability = TextEditingController();
  final __ageController = TextEditingController();
  final __uidController = TextEditingController();
  final ___phoneController = TextEditingController();

  var _age = 0;
  String imageUrl = "";
  var _uid = 0;
  var _contact = '';
  String _yearValue = 'Select';
  String _courseValue = 'Select';
  bool uploadStatus = false;
  String uploadLabel = "Add Profile pic";
  // List of items in our dropdown menu

  var yearItems = [
    'Select',
    'FYJC',
    'SYJC',
    'FY',
    'SY',
    'TY',
  ];

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

  var _validationMessage = "";
  var collegeName = "SELECT";

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
    CollectionReference colref = FirebaseFirestore.instance.collection('SWD');

    Map<String, dynamic> swdMap = {
      "email": _email.text.toLowerCase(),
      "name": _name.text,
      "age": _age,
      "uid": _uid,
      "year": _yearValue,
      "course": _courseValue,
      "disability": _disability.text,
      "phoneNo": _contact,
      "imageUrl": imageUrl,
      "collegeName": collegeName
    };

    colref.doc(_email.text).set(swdMap).then((value) {
      print("Details Added");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => SwdHome(emailText: emailText)));
    }).catchError((error) {
      print("Failed to add details : $error");
    });
  }

  void getCollegeName(college) {
    setState(() {
      collegeName = college;
    });
    print("College selected $collegeName");
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                                "Welcome Dear Student! You are in the right place",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color.fromRGBO(162, 7, 48, 1),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        // const Column(
                        //   children: <Widget>[
                        //     Center(
                        //       child: Text("Welcome Dear Student!",
                        //           style: TextStyle(
                        //               fontSize: 22,
                        //               color: Color.fromRGBO(162, 7, 48, 1),
                        //               fontWeight: FontWeight.bold)),
                        //     ),
                        //     Center(
                        //       child: Text("You're in the",
                        //           style: TextStyle(
                        //               fontSize: 22,
                        //               color: Color.fromRGBO(162, 7, 48, 1),
                        //               fontWeight: FontWeight.bold)),
                        //     ),
                        //     Center(
                        //       child: Text("Right Place!",
                        //           style: TextStyle(
                        //               fontSize: 22,
                        //               color: Color.fromRGBO(162, 7, 48, 1),
                        //               fontWeight: FontWeight.bold)),
                        //     ),
                        //   ],
                        // ),
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
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        hintStyle: TextStyle(fontSize: 15),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5, color: Color.fromRGBO(162, 7, 48, 1)),
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
                      controller: __ageController,
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
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5, color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: __uidController,
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
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5, color: Color.fromRGBO(162, 7, 48, 1)),
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
                      child:
                          // Column(
                          //     children: <Widget>[
                          //       const SizedBox(width: 10),
                          //       const Text(
                          //         "Year: ",
                          //         style: TextStyle(
                          //             color: Color.fromRGBO(162, 7, 48, 1),
                          //             fontSize: 20),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 150),
                          //         child: DropdownButton<String>(
                          //           dropdownColor: Colors.white,
                          //           style: const TextStyle(
                          //               color: Color.fromRGBO(162, 7, 48, 1)),
                          //           value: _yearValue,
                          //           icon: const Icon(Icons.keyboard_arrow_down),
                          //           items: yearItems.map((String year_items) {
                          //             return DropdownMenuItem(
                          //               value: year_items,
                          //               child: Text(year_items),
                          //             );
                          //           }).toList(),
                          //           onChanged: (String? value) => setState(
                          //               () => _yearValue = value.toString()),
                          //         ),
                          //       ),
                          //     ],
                          //   )
                          Row(
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
                            items: yearItems.map((String yearItems) {
                              return DropdownMenuItem(
                                value: yearItems,
                                child: Text(yearItems),
                              );
                            }).toList(),
                            onChanged: (String? value) =>
                                setState(() => _yearValue = value.toString()),
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
                            items: _yearValue == "FYJC" || _yearValue == "SYJC"
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
                            onChanged: (String? value) =>
                                setState(() => _courseValue = value.toString()),
                            //validator: (value) => value == "Select" ? ' Please Select a Valid Option' : null,
                          ),
                        ],
                      ),
                    ),
                    Dropdown(
                      onSelected: getCollegeName,
                      defaultOption: widget.currentCollegeName,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Disability",
                        hintText: "Enter Disability",
                        labelStyle: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        hintStyle: TextStyle(fontSize: 15),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5, color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
                      ),
                      controller: _disability,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Disability';
                        }
                        return null;
                      },
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
                      height: 10,
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
                                              print("tapped on camera button");
                                            });

                                            ImagePicker imgPicker =
                                                ImagePicker();
                                            XFile? file =
                                                await imgPicker.pickImage(
                                                    source: ImageSource.camera);
                                            if (file == null) {
                                              print("No file found ");
                                              setState(() {
                                                uploadStatus = false;
                                              });
                                              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kindly upload a photo")));
                                              return;
                                            }
                                            print("Image path: ${file.path}");
                                            //step 1 completed

                                            //step 2
                                            // create a unique id
                                            String uniqueFileName =
                                                DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();

                                            // Get a reference to storage root
                                            Reference refRoot =
                                                FirebaseStorage.instance.ref();

                                            // If needed mention the exact folder where it has to stored
                                            Reference refDirImages =
                                                refRoot.child("profiles");

                                            //Create a reference to that image which needs to be stored
                                            // Reference refImageToBeUploaded = refDirImages.child("${file?.name}");
                                            Reference refImageToBeUploaded =
                                                refDirImages
                                                    .child(uniqueFileName);

                                            //store the file to that reference
                                            try {
                                              await refImageToBeUploaded
                                                  .putFile(File(file.path));

                                              //get the download url (step 3)

                                              imageUrl =
                                                  await refImageToBeUploaded
                                                      .getDownloadURL();
                                              setState(() {
                                                uploadLabel = "Image Uploaded";
                                              });
                                              print("Image url: $imageUrl");
                                            } on FirebaseException catch (err) {
                                              print(err.message.toString());
                                              setState(() {
                                                uploadLabel =
                                                    "Image not Uploaded";
                                              });
                                            } catch (e) {
                                              setState(() {
                                                uploadLabel =
                                                    "Image not Uploaded";
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
                                          icon: const Icon(Icons.camera_alt),
                                        ),
                                        FloatingActionButton.extended(
                                          onPressed: () async {
                                            setState(() {
                                              uploadStatus = true;
                                              print("tapped on Gallery button");
                                            });
                                            print("Gallery ");
                                            ImagePicker imgPicker =
                                                ImagePicker();
                                            XFile? file =
                                                await imgPicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (file == null) {
                                              print("No file found ");
                                              setState(() {
                                                uploadStatus = false;
                                              });
                                              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kindly upload a photo")));
                                              return;
                                            }
                                            print("Image path: ${file.path}");
                                            //step 1 completed

                                            //step 2
                                            // create a unique id
                                            String uniqueFileName =
                                                DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();

                                            // Get a reference to storage root
                                            Reference refRoot =
                                                FirebaseStorage.instance.ref();

                                            // If needed mention the exact folder where it has to stored
                                            Reference refDirImages =
                                                refRoot.child("profiles");

                                            //Create a reference to that image which needs to be stored
                                            // Reference refImageToBeUploaded = refDirImages.child("${file?.name}");
                                            Reference refImageToBeUploaded =
                                                refDirImages
                                                    .child(uniqueFileName);

                                            //store the file to that reference
                                            try {
                                              await refImageToBeUploaded
                                                  .putFile(File(file.path));

                                              //get the download url (step 3)

                                              imageUrl =
                                                  await refImageToBeUploaded
                                                      .getDownloadURL();
                                              print("Image url: $imageUrl");
                                              setState(() {
                                                uploadLabel = "Image Uploaded";
                                              });
                                            } on FirebaseException catch (err) {
                                              print(err.message.toString());
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
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //  Contact no. Field
                    TextFormField(
                      controller: ___phoneController,
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
                            fontSize: 20, color: Color.fromRGBO(162, 7, 48, 1)),
                        hintStyle: TextStyle(fontSize: 15),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(71, 71, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1.5, color: Color.fromRGBO(162, 7, 48, 1)),
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
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        dropDownValidate();
                        if (collegeName == 'SELECT') {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(
                                        "Do select your institute name"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                          return;
                        }
                        if (uploadStatus) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(
                                        "Your profile photo is yet to be uploaded"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                          return;
                        }
                        if ((_formKey.currentState!.validate() == true) &&
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
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _email.text = emailText;
    if (widget.currentDisability != null) {
      _disability.text = widget.currentDisability.toString();
    }
    if (widget.currentAge != null) {
      __ageController.text = widget.currentAge.toString();
      setState(() {
        _age = int.parse(widget.currentAge.toString());
      });
    }

    if (widget.currentUid != null) {
      __uidController.text = widget.currentUid.toString();
      setState(() {
        _uid = int.parse(widget.currentUid.toString());
      });
    }

    if (widget.currentContact != null) {
      ___phoneController.text = widget.currentContact.toString();
      _contact = widget.currentContact.toString();
    }

    if (widget.currentName != null) {
      _name.text = widget.currentName.toString();
    }

    if (widget.currentProfilePhoto != null &&
        widget.currentProfilePhoto.toString() != "") {
      print("Profile Photo: ${widget.currentProfilePhoto}");
      imageUrl = widget.currentProfilePhoto.toString();
      print("uploaded picture: ${imageUrl}");
      setState(() {
        uploadLabel = "Image Uploaded";
      });
    }

    if (widget.currentCollegeName != null) {
      setState(() {
        collegeName = widget.currentCollegeName.toString();
        print("updated college name");
      });
    }

    if (widget.currentYear != null) {
      setState(() {
        _yearValue = widget.currentYear.toString();
      });
    }

    if (widget.currentCourse != null) {
      setState(() {
        _courseValue = widget.currentCourse.toString();
      });
    }
  }
}
