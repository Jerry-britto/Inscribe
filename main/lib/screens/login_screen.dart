import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Account",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(227, 161, 43, 0.3),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/images/xaviers_logo.png",
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/images/XRCVC.png",
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kindly enter your email";
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(162, 7, 48, 1), width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter Email",
                        prefixIcon: const Icon(Icons.mail)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Kindly enter your Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: "Enter Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_sharp))),
                    obscureText: isVisible,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          print("Forgot password");
                        },
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.black87),
                        )),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                             ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset("assets/images/google_icon.webp"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have a account ?",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      TextButton(
                          onPressed: () {
                            print("go to sign up");
                          },
                          child: const Text(
                            "Sign up",
                            style:
                                TextStyle(color: Color.fromRGBO(162, 7, 48, 1)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )));
}
