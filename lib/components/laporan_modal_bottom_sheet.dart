import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum JenisLaporan {
  penjualanDiAtasHET('Penjualan di atas HET'),
  penyelewenganPenyaluran('Penyelewengan penyaluran'),
  pengoplosan('Pengoplosan'),
  lainnya('Lainnya');

  const JenisLaporan(this.value);
  final String value;
}

class MyLaporanModalBottomSheet extends StatefulWidget {
  const MyLaporanModalBottomSheet({super.key, required this.pangkalan});

  final Pangkalan pangkalan;

  @override
  State<MyLaporanModalBottomSheet> createState() =>
      _MyLaporanModalBottomSheetState();
}

class _MyLaporanModalBottomSheetState extends State<MyLaporanModalBottomSheet> {
  JenisLaporan? _jenisLaporan;
  String _deskripsi = '';

  Future<void> _onSubmit() async {
    showLoadingScreen(context);

    final Pengguna pengguna = context.read<PenggunaMasukCubit>().state!;

    final url = '${dotenv.env['SERVER_URL']}/lapor-pangkalan/';

    final reqBody = {
      "nim_pelapor": pengguna.nik,
      "nama_pelapor": pengguna.nama,
      "id_pangkalan": widget.pangkalan.id,
      "nama_pangkalan": widget.pangkalan.nama,
      "tanggal": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      "deskripsi": _deskripsi
    };

    try {
      final Map<String, dynamic> resBody = jsonDecode((await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody),
      ))
          .body);

      Navigator.of(context).pop();
      Navigator.of(context).pop();

      if (resBody['status'] == 'failed') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resBody['message']),
          backgroundColor: Theme.of(context).colorScheme.primary,
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Laporan terkirim'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ));
      }
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // height: 300,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18),
            DropdownMenu(
              label: const Text('Jenis Laporan'),
              onSelected: (value) => setState(() => _jenisLaporan = value),
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: JenisLaporan.penjualanDiAtasHET,
                  label: JenisLaporan.penjualanDiAtasHET.value,
                ),
                DropdownMenuEntry(
                  value: JenisLaporan.penyelewenganPenyaluran,
                  label: JenisLaporan.penyelewenganPenyaluran.value,
                ),
                DropdownMenuEntry(
                  value: JenisLaporan.pengoplosan,
                  label: JenisLaporan.pengoplosan.value,
                ),
                DropdownMenuEntry(
                  value: JenisLaporan.lainnya,
                  label: JenisLaporan.lainnya.value,
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (value) => _deskripsi = value,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                label: Text(
                  'Masukkan Deskripsi Laporan',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _jenisLaporan == null ? null : () => _onSubmit(),
                child: const Text(
                  'Kirim Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
