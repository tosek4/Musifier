import 'package:flutter/material.dart';
import 'package:musifier/pages/profilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        brightness: Brightness.dark, // Use dark mode for consistency
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Nunito-Regular',
      ),
      home: ProfilePage(), // Calls the screen you sent above
    );
  }
}
