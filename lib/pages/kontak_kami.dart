import 'package:flutter/material.dart';
import 'package:gasku/widgets/kontak_kami_list_tile.dart';

class MyKontakKamiPage extends StatelessWidget {
  const MyKontakKamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kontak Kami',
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
                'Kontak Kami',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 19),
              const KontakKamiListTile(
                title: 'Nomor Telepon:',
                body: '0877-1655-5618 - (Senin - Jumat, 09:00 - 17:00 WITA)',
              ),
              const KontakKamiListTile(
                title: 'Email:',
                body: 'Dukungan Teknis: gasku@gmail.com',
              ),
              const KontakKamiListTile(
                title: 'Alamat:',
                body:
                    'PT. Gasku Indonesia\nJl. Banjar Indah Komp. Mekar Sari, Kota Banjarmasin, Indonesia',
              ),
              const KontakKamiListTile(
                title: 'Jam Operasional',
                body: 'Senin - Jumat: 09:00 - 17:00 WIB\nSabtu - Minggu: Tutup',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
