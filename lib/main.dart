import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gasku/cubits/daftar_pangkalan.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/cubits/posisi_pengguna.dart';
import 'package:gasku/pages/main.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PenggunaMasukCubit()),
        BlocProvider(create: (_) => DaftarPangkalanCubit()),
        BlocProvider(create: (_) => PosisiPenggunaCubit()),
      ],
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
      title: 'GasKu',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff4A6BD4),
            primary: const Color(0xff4A6BD4),
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          bottomSheetTheme: const BottomSheetThemeData(
            showDragHandle: true,
            dragHandleSize: Size(100, 10),
            dragHandleColor: Colors.white,
            backgroundColor: Colors.transparent,
          )),
      // home: MyMasukPage(),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else {
            final nikPengguna = snapshot.data!.getString('nik_pengguna_masuk');

            if (nikPengguna == null) return const MyMasukPage();

            return FutureBuilder(
              future: context
                  .read<PenggunaMasukCubit>()
                  .masukTanpaSandi(nik: nikPengguna),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (context.read<PenggunaMasukCubit>().state == null) {
                    return const MyMasukPage();
                  }

                  return const MyMainPage();
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
