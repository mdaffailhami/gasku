import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gasku/models/user.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:gasku/widgets/filled_button.dart';
import 'package:gasku/widgets/text_form_field.dart';

class MyDaftarPage extends StatefulWidget {
  const MyDaftarPage({super.key});

  @override
  State<MyDaftarPage> createState() => _MyDaftarPageState();
}

class _MyDaftarPageState extends State<MyDaftarPage> {
  final _formKey = GlobalKey<FormState>();

  String _nama = '';
  String _nik = '';
  String _kk = '';
  String _noTelepon = '';
  String _kataSandi = '';

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    showLoadingScreen(context);

    await User.add(
      User(
        nik: _nik,
        nama: _nama,
        kk: _kk,
        noTelepon: _noTelepon,
        kataSandi: _kataSandi,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MyMasukPage()),
      (_) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Akun berhasil didaftarkan'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      action: SnackBarAction(
        label: 'Tutup',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          tooltip: 'Kembali',
        ),
        centerTitle: true,
        title: Text(
          'Daftar Akun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      title: 'Nama Lengkap',
                      label: 'Masukkan Nama Anda',
                      onChanged: (value) => _nama = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        if (value.length > 40) {
                          return 'Nama maksimal 40 karakter';
                        }
                        return null;
                      },
                    ),
                    MyTextFormField(
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
                    ),
                    MyTextFormField(
                      title: 'Nomor Kartu Keluarga (KK)',
                      label: 'Masukkan Nomor KK Anda',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _kk = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'KK tidak boleh kosong';
                        }
                        if (value.length != 16) {
                          return 'KK harus 16 digit';
                        }
                        return null;
                      },
                    ),
                    MyTextFormField(
                      prefix: Text('+62'),
                      keyboardType: TextInputType.number,
                      title: 'Nomor Telepon',
                      label: 'Masukkan Nomor Telepon Anda',
                      onChanged: (value) => _noTelepon = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong';
                        }
                        if (value.length > 20) {
                          return 'Nomor Telepon maksimal 20 karakter';
                        }
                        return null;
                      },
                    ),
                    MyTextFormField(
                      isObscure: true,
                      title: 'Kata Sandi',
                      label: 'Masukkan Kata Sandi',
                      onChanged: (value) => _kataSandi = value,
                      onFieldSubmitted: onSubmit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata Sandi tidak boleh kosong';
                        }
                        if (value.length > 40) {
                          return 'Kata Sandi maksimal 40 karakter';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: MyFilledButton(text: 'Daftar', onPressed: onSubmit),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Sudah punya akun? ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Masuk di sini',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
