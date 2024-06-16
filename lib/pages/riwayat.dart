import 'package:flutter/material.dart';
import 'package:gasku/widgets/e_tiket.dart';
import 'package:gasku/widgets/filter_chip.dart';

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
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ETiket(),
                ETiket(),
                ETiket(),
                ETiket(),
                ETiket(),
                ETiket(),
                ETiket(),
                ETiket(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
