import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:gasku/widgets/filled_button.dart';
import 'package:gasku/widgets/text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class MyEditProfilPage extends StatefulWidget {
  const MyEditProfilPage({super.key});

  @override
  State<MyEditProfilPage> createState() => _MyEditProfilPageState();
}

class _MyEditProfilPageState extends State<MyEditProfilPage> {
  final _formKey = GlobalKey<FormState>();

  late final Pengguna? _pengguna;

  late String _nama;
  late String _email;
  String? _foto;

  @override
  void initState() {
    super.initState();

    _pengguna = context.read<PenggunaMasukCubit>().state;

    _nama = _pengguna!.nama;
    _email = _pengguna.email;
    _foto = _pengguna.foto;
  }

  Future<void> _onUploadPhotoButtonPressed() async {
    XFile? photoInXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (photoInXFile == null) return;

    File photo = File(photoInXFile.path);
    final photoAsBytes = await photo.readAsBytes();
    setState(() => _foto = base64.encode(photoAsBytes));
  }

  Future<void> _onSubmitButtonPressed() async {
    if (!_formKey.currentState!.validate()) return;

    showLoadingScreen(context);

    try {
      final pengguna =
          _pengguna!.copyWith(nama: _nama, email: _email, foto: _foto);

      await context.read<PenggunaMasukCubit>().edit(pengguna);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Edit profil berhasil'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profil',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black87,
                        builder: (context) => Dialog(
                          child: _foto == null
                              ? Image.asset('assets/default_pfp.jpg')
                              : Image.memory(base64Decode(_foto!)),
                        ),
                      );
                    },
                    child: _foto == null
                        ? CircleAvatar(
                            radius: 70,
                            foregroundImage:
                                AssetImage('assets/default_pfp.jpg'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            foregroundImage: MemoryImage(base64Decode(_foto!)),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton.small(
                      onPressed: () => _onUploadPhotoButtonPressed(),
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      title: 'Nama Lengkap',
                      label: 'Masukkan Nama Anda',
                      initialValue: _nama,
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
                      keyboardType: TextInputType.emailAddress,
                      title: 'Alamat Email',
                      label: 'Masukkan Alamat Email Anda',
                      initialValue: _email,
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
                  ],
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: MyFilledButton(
                  text: 'Simpan',
                  onPressed: () => _onSubmitButtonPressed(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
