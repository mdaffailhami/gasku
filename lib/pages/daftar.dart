import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gasku/components/filled_button.dart';
import 'package:gasku/components/text_form_field.dart';

class MyDaftarPage extends StatefulWidget {
  const MyDaftarPage({super.key});

  @override
  State<MyDaftarPage> createState() => _MyDaftarPageState();
}

class _MyDaftarPageState extends State<MyDaftarPage> {
  final _formKey = GlobalKey<FormState>();

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
                child: const Column(
                  children: [
                    MyTextFormField(
                      title: 'Nama Lengkap',
                      label: 'Masukkan Nama Anda',
                    ),
                    MyTextFormField(
                      title: 'Nomor Induk Kependudukan (NIK)',
                      label: 'Masukkan NIK Anda',
                    ),
                    MyTextFormField(
                      title: 'Nomor Kartu Keluarga (KK)',
                      label: 'Masukkan Nomor KK Anda',
                    ),
                    MyTextFormField(
                      prefix: Text('+62'),
                      keyboardType: TextInputType.number,
                      title: 'Nomor Telepon',
                      label: 'Masukkan Nomor Telepon Anda',
                    ),
                    MyTextFormField(
                      isObscure: true,
                      title: 'Kata Sandi',
                      label: 'Masukkan Kata Sandi',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              const SizedBox(
                width: double.infinity,
                child: MyFilledButton(text: 'Daftar'),
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
