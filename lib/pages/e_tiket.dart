import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyETiketPage extends StatelessWidget {
  const MyETiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PenggunaMasukCubit, Pengguna?>(
      builder: (context, state) {
        if (state == null) return SizedBox.shrink();

        final DateTime dateTime = DateTime.now();
        final DateTime monday =
            dateTime.subtract(Duration(days: dateTime.weekday - 1));

        final String formattedMonday =
            DateFormat('dd-MM-yyyy').format(monday).toString();
        final String formattedMonday2 =
            DateFormat('ddMMyyyy').format(monday).toString();

        final DateTime expirationDate = monday.add(Duration(days: 6));
        final String formattedExpirationDate =
            DateFormat('dd/MM/yyyy').format(expirationDate).toString();

        final String eTiketUrl =
            '${dotenv.env['SERVER_URL']}/konfirmasi-e-tiket/${state.nik}/${sha1.convert(utf8.encode('${state.nik}($formattedMonday)')).toString()}';

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
                          radius: 37,
                          backgroundColor: Colors.white,
                          child: state.foto == null
                              ? CircleAvatar(
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
                            Icon(
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
                        SizedBox(height: 20),
                        QrImageView(
                          data: eTiketUrl,
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
                          'LPG-$formattedMonday2',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        Text(
                          'Berlaku sampai $formattedExpirationDate',
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
      },
    );
  }
}
