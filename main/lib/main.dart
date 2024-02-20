import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:main/firebase_options.dart';
import 'package:main/screens/details_pages/scribe_details.dart';
import 'package:main/screens/login/login_screen.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await findSystemLocale();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: const Scaffold(
        body: Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
