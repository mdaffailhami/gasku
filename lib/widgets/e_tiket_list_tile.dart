import 'package:flutter/material.dart';
import 'package:gasku/models/e_tiket.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyETiketListTile extends StatelessWidget {
  const MyETiketListTile(
      {super.key, required this.eTiket, required this.nikPemilik});

  final ETiket eTiket;
  final String nikPemilik;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          DateFormat('dd-MM-yyyy').format(eTiket.tanggal),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 190,
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'E-Tiket LPG Bersubsidi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QrImageView(
                        data: eTiket.generateUrl(nikPemilik),
                        version: QrVersions.auto,
                        size: 80,
                        backgroundColor: Colors.white,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nomor E-Tiket',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            eTiket.nomor,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                          Text(
                            'Berlaku sampai ${eTiket.tanggalKedaluwarsa}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
