import 'package:flutter/material.dart';
import 'package:gasku/pages/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/masuk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GasKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff4A6BD4),
          primary: const Color(0xff4A6BD4),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyMainPage(),
    );
  }
}
