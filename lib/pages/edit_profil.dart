import 'package:flutter/material.dart';
import 'package:gasku/widgets/filled_button.dart';
import 'package:gasku/widgets/text_form_field.dart';

class MyEditProfilPage extends StatefulWidget {
  const MyEditProfilPage({super.key});

  @override
  State<MyEditProfilPage> createState() => _MyEditProfilPageState();
}

class _MyEditProfilPageState extends State<MyEditProfilPage> {
  final _formKey = GlobalKey<FormState>();

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
                          child: Image.network(
                              'https://avatars.githubusercontent.com/u/74972129?v=4'),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/74972129?v=4',
                      ),
                      radius: 70,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton.small(
                      onPressed: () {},
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
                child: const Column(
                  children: [
                    MyTextFormField(
                      title: 'Nama Lengkap',
                      label: 'Masukkan Nama Anda',
                      initialValue: 'Muhammad Daffa Ilhami',
                    ),
                    MyTextFormField(
                      prefix: Text('+62'),
                      keyboardType: TextInputType.number,
                      title: 'Nomor Telepon',
                      label: 'Masukkan Nomor Telepon Anda',
                      initialValue: '818374374',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              const SizedBox(
                width: double.infinity,
                child: MyFilledButton(text: 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
