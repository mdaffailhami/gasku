import 'package:flutter/material.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/ganti_kata_sandi.dart';
import 'package:gasku/pages/verifikasi_otp.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:gasku/widgets/text_form_field.dart';

class MyGantiKataSandiDialog extends StatefulWidget {
  const MyGantiKataSandiDialog({super.key});

  @override
  State<MyGantiKataSandiDialog> createState() => _MyGantiKataSandiDialogState();
}

class _MyGantiKataSandiDialogState extends State<MyGantiKataSandiDialog> {
  final _formKey = GlobalKey<FormState>();

  String _nik = '';

  Future onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    showLoadingScreen(context);

    try {
      final Pengguna pengguna = await Pengguna.get(_nik);

      String kodeVerifikasi =
          await Pengguna.kirimEmailVerifikasi(pengguna.email);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MyVerifikasiOTPPage(
            pengguna: pengguna,
            otp: kodeVerifikasi,
            onVerified: (Pengguna pengguna) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyGantiKataSandiPage(pengguna: pengguna),
                ),
              );
            },
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Gagal mengirim kode verifikasi'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tutup'))
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
      title: const Text('Ganti kata sandi'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => onSubmit(),
          child: const Text('Kirim'),
        ),
      ],
      content: Form(
        key: _formKey,
        child: MyTextFormField(
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
      ),
    );
  }
}
