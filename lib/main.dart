import 'package:doffa/api/api_provider.dart';
import 'package:doffa/auth/auth_provider.dart';
import 'package:doffa/auth/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.light().copyWith(primary: Color(0xff4288f5)),
      ),
      debugShowCheckedModeBanner: true,
      home: AuthWrapper(),
    );
  }
}
