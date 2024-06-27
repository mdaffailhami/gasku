import 'package:flutter/material.dart';
import 'package:gasku/widgets/faq_list_tile.dart';

class MyFAQPage extends StatelessWidget {
  const MyFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FAQ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FAQ',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 19),
              const MyFAQListTile(
                title: 'Pendaftaran dan Akun',
                subtitle: 'Bagaimana cara mendaftar di aplikasi ini?',
                body:
                    'Anda dapat mendaftar dengan mengunduh aplikasi dari Google Play Store, lalu mengikuti petunjuk pendaftaran yang ada di aplikasi.',
              ),
              const MyFAQListTile(
                title: null,
                subtitle:
                    'Saya lupa kata sandi akun saya, bagaimana cara meresetnya?',
                body:
                    'Anda dapat mereset kata sandi dengan mengklik "Lupa Kata Sandi" di halaman login dan mengikuti petunjuk yang dikirimkan ke email Anda.',
              ),
              const MyFAQListTile(
                title: 'Keamanan dan Privasi',
                subtitle: 'Bagaimana data pribadi saya dilindungi?',
                body:
                    'Kami menggunakan enkripsi SSL dan protokol keamanan lainnya untuk melindungi data pribadi Anda.',
              ),
              const MyFAQListTile(
                title: 'Masalah Teknis',
                subtitle:
                    'Apa yang harus dilakukan jika aplikasi tidak berfungsi dengan baik?',
                body:
                    'Coba tutup aplikasi dan buka kembali, atau restart perangkat Anda. Jika masalah masih berlanjut, hubungi dukungan teknis melalui email gasku@gmail.com.',
              ),
              const MyFAQListTile(
                title: null,
                subtitle: 'Bagaimana cara melaporkan bug atau masalah lainnya?',
                body:
                    'Anda dapat melaporkan bug atau masalah lainnya melalui fitur pusat bantuan di halaman bagian profil anda',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
