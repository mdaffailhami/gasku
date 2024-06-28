import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/edit_profil.dart';
import 'package:gasku/pages/faq.dart';
import 'package:gasku/pages/kontak_kami.dart';
import 'package:gasku/pages/masuk.dart';
import 'package:gasku/pages/pengajuan_pangkalan.dart';
import 'package:gasku/utils/show_loading_screen.dart';
import 'package:gasku/widgets/divider.dart';
import 'package:gasku/widgets/list_tile_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilPage extends StatelessWidget {
  const MyProfilPage({super.key});

  Future<void> onKeluarButtonPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                showLoadingScreen(context);

                try {
                  (await SharedPreferences.getInstance())
                      .remove('nik_pengguna_masuk');

                  if (!context.mounted) throw 'Terjadi kesalahan';

                  context.read<PenggunaMasukCubit>().keluar();

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
              child: const Text('Keluar'),
            ),
          ],
          content: const Text('Apakah kamu yakin ingin keluar?'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Card(
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: Column(
                children: [
                  BlocBuilder<PenggunaMasukCubit, Pengguna?>(
                    builder: (context, pengguna) {
                      if (pengguna == null) return const SizedBox.shrink();

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pengguna.foto == null
                                ? const CircleAvatar(
                                    radius: 30,
                                    foregroundImage:
                                        AssetImage('assets/default_pfp.jpg'),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    foregroundImage: MemoryImage(
                                        base64Decode(pengguna.foto!)),
                                  ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pengguna.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.tag,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      Flexible(
                                        child: Text(
                                          pengguna.nik,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      Flexible(
                                        child: Text(
                                          pengguna.email,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MyEditProfilPage(),
                                ),
                              ),
                              icon: const Icon(Icons.edit_square, size: 28),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.contact_emergency_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'E-Kartu',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // MyListTileButton(
                  //   icon: Icons.question_mark,
                  //   text: 'Pusat Bantuan',
                  //   onTap: () {},
                  // ),
                  // const MyDivider(height: 1, indent: 12, endIndent: 12),
                  // MyListTileButton(
                  //   icon: Icons.shield_moon_outlined,
                  //   text: 'Pemberitahuan Privasi',
                  //   onTap: () {},
                  // ),
                  // const MyDivider(height: 1, indent: 12, endIndent: 12),
                  MyListTileButton(
                    icon: Icons.question_answer_outlined,
                    text: 'FAQ',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyFAQPage(),
                      ),
                    ),
                  ),
                  const MyDivider(height: 1, indent: 12, endIndent: 12),
                  MyListTileButton(
                    icon: Icons.assignment_outlined,
                    text: 'Pengajuan Pangkalan',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyPengajuanPangkalanPage(),
                      ),
                    ),
                  ),
                  const MyDivider(height: 1, indent: 12, endIndent: 12),
                  MyListTileButton(
                    icon: Icons.contacts_outlined,
                    text: 'Kontak Kami',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyKontakKamiPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => onKeluarButtonPressed(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                label: Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                icon: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
