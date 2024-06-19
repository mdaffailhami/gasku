import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gasku/widgets/filled_button.dart';
import 'package:gasku/widgets/text_form_field.dart';
import 'package:gasku/pages/daftar.dart';

class MyMasukPage extends StatefulWidget {
  const MyMasukPage({super.key});

  @override
  State<MyMasukPage> createState() => _MyMasukPageState();
}

class _MyMasukPageState extends State<MyMasukPage> {
  final _formKey = GlobalKey<FormState>();

  String _nik = '';
  String _kataSandi = '';

  Future<void> onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gasku_logo.png',
              width: 150,
            ),
            Text(
              'Halo,\nSelamat Datang.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                    isObscure: true,
                    title: 'Kata Sandi',
                    label: 'Masukkan Kata Sandi Anda',
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Lupa Kata Sandi?',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 35),
            const SizedBox(
              width: double.infinity,
              child: MyFilledButton(text: 'Masuk'),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Belum punya akun? ',
                style: Theme.of(context).textTheme.bodySmall,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Daftar di sini',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyDaftarPage(),
                          ),
                        );
                      },
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
