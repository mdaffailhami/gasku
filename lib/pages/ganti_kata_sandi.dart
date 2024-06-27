import 'package:flutter/material.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:gasku/widgets/text_form_field.dart';

class MyGantiKataSandiPage extends StatefulWidget {
  const MyGantiKataSandiPage({super.key, required this.pengguna});

  final Pengguna pengguna;

  @override
  State<MyGantiKataSandiPage> createState() => _MyGantiKataSandiPageState();
}

class _MyGantiKataSandiPageState extends State<MyGantiKataSandiPage> {
  final _formKey = GlobalKey<FormState>();

  String _kataSandi = '';

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    showLoadingScreen(context);

    try {
      await Pengguna.gantiKataSandi(widget.pengguna.nik, _kataSandi);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ganti password berhasil'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
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
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ganti Kata Sandi',
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
              'Masukkan kata sandi baru',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Silahkan masukkan kata sandi baru yang anda inginkan, pastikan susah ditebak ya :)',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: MyTextFormField(
                startPadding: false,
                isObscure: true,
                title: 'Kata Sandi Baru',
                label: 'Masukkan Kata Sandi Baru',
                onChanged: (value) => _kataSandi = value,
                onFieldSubmitted: () => onSubmit(),
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
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => onSubmit(),
                child: const Text('Simpan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
