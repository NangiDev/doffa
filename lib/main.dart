import 'package:flutter/material.dart';
import 'widgets/my_logo.dart';
import 'widgets/my_date_pickers.dart';
import 'widgets/my_graph.dart';
import 'widgets/my_data.dart';
import 'widgets/my_progress.dart';
import 'widgets/my_ratio.dart';
import 'widgets/ads_google.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doffa - Fitness Tracker',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(primary: Color(0xFF3272D6)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8EB8F9), Color(0xFF3272D6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 400, maxWidth: 600),
              child: MyDoffa(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDoffa extends StatelessWidget {
  const MyDoffa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyLogo(),
        MyDatePickers(title: "Start Date"),
        MyDatePickers(title: "End Date"),
        MyGraph(),
        MyData(),
        MyProgress(),
        MyRatio(),
        AdsGoogle(),
      ],
    );
  }
}
