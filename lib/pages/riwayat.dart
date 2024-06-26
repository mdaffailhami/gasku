import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/e_tiket.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/widgets/e_tiket_list_tile.dart';
import 'package:gasku/widgets/filter_chip.dart';
import 'package:intl/intl.dart';

class MyRiwayatPage extends StatefulWidget {
  const MyRiwayatPage({super.key});

  @override
  State<MyRiwayatPage> createState() => _MyRiwayatPageState();
}

class _MyRiwayatPageState extends State<MyRiwayatPage> {
  bool _isSemuaSelected = true;
  bool _isBulanIniSelected = false;
  bool _isTahunIniSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PenggunaMasukCubit, Pengguna?>(
      builder: (context, state) {
        if (state == null) return SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyFilterChip(
                    label: 'Semua',
                    isSelected: _isSemuaSelected,
                    onSelected: (_) {
                      setState(() {
                        _isSemuaSelected = true;
                        _isBulanIniSelected = false;
                        _isTahunIniSelected = false;
                      });
                    },
                  ),
                  MyFilterChip(
                    label: 'Bulan Ini',
                    isSelected: _isBulanIniSelected,
                    onSelected: (_) {
                      setState(() {
                        _isSemuaSelected = false;
                        _isBulanIniSelected = true;
                        _isTahunIniSelected = false;
                      });
                    },
                  ),
                  MyFilterChip(
                    label: 'Tahun Ini',
                    isSelected: _isTahunIniSelected,
                    onSelected: (value) {
                      setState(() {
                        _isSemuaSelected = false;
                        _isBulanIniSelected = false;
                        _isTahunIniSelected = true;
                      });
                    },
                  ),
                ],
              ),
              Divider(height: 10),
              Builder(builder: (context) {
                final reversedList = state.riwayatETiket.reversed.toList();
                final eTiketList = <ETiket>[];

                if (_isBulanIniSelected) {
                  for (String eTiket in reversedList) {
                    final tanggal = DateFormat('dd-MM-yyyy').parse(eTiket);
                    final now = DateTime.now();

                    if (tanggal.month == now.month &&
                        tanggal.year == now.year) {
                      eTiketList.add(ETiket(tanggal: tanggal));
                    }
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: eTiketList.length,
                      itemBuilder: (context, i) {
                        return MyETiketListTile(
                          eTiket: eTiketList[i],
                          nikPemilik: state.nik,
                        );
                      },
                    ),
                  );
                } else if (_isTahunIniSelected) {
                  for (String eTiket in reversedList) {
                    final tanggal = DateFormat('dd-MM-yyyy').parse(eTiket);
                    final now = DateTime.now();

                    if (tanggal.year == now.year) {
                      eTiketList.add(ETiket(tanggal: tanggal));
                    }
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: eTiketList.length,
                      itemBuilder: (context, i) {
                        return MyETiketListTile(
                          eTiket: eTiketList[i],
                          nikPemilik: state.nik,
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: reversedList.length,
                      itemBuilder: (context, i) {
                        final eTiket = ETiket(
                          tanggal:
                              DateFormat('dd-MM-yyyy').parse(reversedList[i]),
                        );

                        return MyETiketListTile(
                          eTiket: eTiket,
                          nikPemilik: state.nik,
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        );
      },
    );
  }
}
