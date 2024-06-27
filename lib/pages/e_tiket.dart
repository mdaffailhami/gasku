import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/e_tiket.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyETiketPage extends StatelessWidget {
  const MyETiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PenggunaMasukCubit, Pengguna?>(
      builder: (context, state) {
        if (state == null) return const SizedBox.shrink();

        final DateTime currentDateTime = DateTime.now();
        final DateTime senin = currentDateTime
            .subtract(Duration(days: currentDateTime.weekday - 1));

        final eTiket = ETiket(tanggal: senin);

        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 620,
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
                          radius: 37,
                          backgroundColor: Colors.white,
                          child: state.foto == null
                              ? const CircleAvatar(
                                  radius: 35,
                                  foregroundImage:
                                      AssetImage('assets/default_pfp.jpg'),
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  foregroundImage: MemoryImage(
                                    base64Decode(state.foto!),
                                  ),
                                ),
                        ),
                        Text(
                          state.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.tag,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text(
                              state.nik,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        QrImageView(
                          data: eTiket.generateUrl(state.nik),
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.width * 0.55,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Nomor E-Tiket',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          eTiket.nomor,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        Text(
                          'Berlaku sampai ${eTiket.tanggalKedaluwarsa}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
