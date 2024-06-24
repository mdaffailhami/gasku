import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gasku/pages/ganti_kata_sandi.dart';

class MyVerifikasiOTPPage extends StatefulWidget {
  const MyVerifikasiOTPPage({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<MyVerifikasiOTPPage> createState() => _MyVerifikasiOTPPageState();
}

class _MyVerifikasiOTPPageState extends State<MyVerifikasiOTPPage> {
  String _otp = '';

  Future onSubmit() async {
    if (_otp != widget.otp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Kode verifikasi salah'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyGantiKataSandiPage(email: widget.email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Verifikasi OTP',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan kode verifikasi',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kami telah mengirimkan email verifikasi ke alamat email ${widget.email}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            OtpTextField(
              numberOfFields: 5,
              borderColor: Theme.of(context).colorScheme.primary,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              onSubmit: (String verificationCode) {
                _otp = verificationCode;

                onSubmit();
              }, // end onSubmit
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => onSubmit(),
                child: Text('Verifikasi'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
