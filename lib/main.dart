import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gasku/firebase_options.dart';
import 'package:gasku/pages/main.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          bottomSheetTheme: BottomSheetThemeData(
            showDragHandle: true,
            dragHandleSize: Size(100, 10),
            dragHandleColor: Colors.white,
            backgroundColor: Colors.transparent,
          )),
      home: const MyMasukPage(),
    );
  }
}
