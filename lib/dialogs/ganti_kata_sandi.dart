import 'package:flutter/material.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/verifikasi_otp.dart';
import 'package:gasku/widgets/text_form_field.dart';

class MyGantiKataSandiDialog extends StatefulWidget {
  const MyGantiKataSandiDialog({super.key});

  @override
  State<MyGantiKataSandiDialog> createState() => _MyGantiKataSandiDialogState();
}

class _MyGantiKataSandiDialogState extends State<MyGantiKataSandiDialog> {
  String _nik = '';

  Future onSubmit() async {
    try {
      final Pengguna pengguna = await Pengguna.get(_nik);

      print(pengguna);

      String kodeVerifikasi =
          await Pengguna.kirimEmailVerifikasi(pengguna.email);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MyVerifikasiOTPPage(
            email: pengguna.email,
            otp: kodeVerifikasi,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Gagal mengirim kode verifikasi'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Tutup'))
            ],
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ganti kata sandi'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () => onSubmit(),
          child: Text('Kirim'),
        ),
      ],
      content: MyTextFormField(
        startPadding: false,
        title: 'Nomor Induk Kependudukan (NIK)',
        label: 'Masukkan NIK Anda',
        keyboardType: TextInputType.number,
        onChanged: (value) => _nik = value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'NIK tidak boleh kosong';
          }
          if (value.length != 16) {
            return 'NIK harus 16 digit';
          }
          return null;
        },
        onFieldSubmitted: () => onSubmit(),
      ),
    );
  }
}
