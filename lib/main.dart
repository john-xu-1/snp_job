import 'package:flutter/material.dart';
//import 'package:snp_job/jobmatches.dart';
import 'home.dart';
import 'color_scheme.dart';
//import 'entrance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(colorScheme: const MyColors()),
      home: const Home(loggedInEmail: "", accommodations: "",)
    );
  }
}

