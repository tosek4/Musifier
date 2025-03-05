import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musifier/widgets/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:musifier/providers/musicPlayerProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicPlayerProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Nunito-Regular',
      ),
      home: const WidgetTree(),
    );
  }
}
