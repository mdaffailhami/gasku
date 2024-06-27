import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:gasku/pages/verifikasi_otp.dart';
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
  String _email = '';
  String _kataSandi = '';

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    showLoadingScreen(context);

    try {
      final pengguna = Pengguna(
        nik: _nik,
        nama: _nama,
        kk: _kk,
        email: _email,
        kataSandi: _kataSandi,
      );

      String kodeVerifikasi =
          await Pengguna.kirimEmailVerifikasi(pengguna.email);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MyVerifikasiOTPPage(
            pengguna: pengguna,
            otp: kodeVerifikasi,
            onVerified: (Pengguna pengguna) async {
              showLoadingScreen(context);

              try {
                await Pengguna.add(pengguna);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Buat akun berhasil'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  action: SnackBarAction(
                    label: 'Tutup',
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ));

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MyMasukPage()),
                  (_) => false,
                );
              } catch (e) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  action: SnackBarAction(
                    label: 'Tutup',
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ));
              }
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
                      keyboardType: TextInputType.emailAddress,
                      title: 'Alamat Email',
                      label: 'Masukkan Alamat Email Anda',
                      onChanged: (value) => _email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alamat Email tidak boleh kosong';
                        }

                        if (value.length > 40) {
                          return 'Alamat Email maksimal 40 karakter';
                        }

                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);

                        if (!emailValid) {
                          return 'Alamat Email tidak valid';
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
