import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gasku/components/filled_button.dart';
import 'package:gasku/components/text_form_field.dart';

class MyMasukPage extends StatefulWidget {
  const MyMasukPage({super.key});

  @override
  State<MyMasukPage> createState() => _MyMasukPageState();
}

class _MyMasukPageState extends State<MyMasukPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const Column(
                children: [
                  MyTextFormField(
                    title: 'Nomor Induk Kependudukan (NIK)',
                    label: 'Masukkan NIK Anda',
                  ),
                  MyTextFormField(
                    isObscure: true,
                    title: 'Kata Sandi',
                    label: 'Masukkan Kata Sandi Anda',
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
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
