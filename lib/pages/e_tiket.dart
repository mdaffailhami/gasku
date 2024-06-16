import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyETiketPage extends StatelessWidget {
  const MyETiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 620,
        padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'E-Tiket\nLPG Bersubsidi',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 37.5,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/74972129?v=4',
                        ),
                        radius: 36,
                      ),
                    ),
                    Text(
                      'Muhammad Daffa Ilhami',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tag,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '612896192837',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    QrImageView(
                      data: '1234567890',
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.55,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Nomor E-Tiket',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      'LPG-2024APR02',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'Berlaku sampai 25/04/2024',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
