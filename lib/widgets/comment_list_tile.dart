import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gasku/models/pengguna.dart';

class MyCommentListTile extends StatelessWidget {
  const MyCommentListTile({super.key, required this.ulasan});

  final Map ulasan;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Pengguna.get(ulasan['nik']),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final pengguna = snapshot.data;

        if (pengguna == null) return const SizedBox.shrink();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: pengguna.foto == null
                  ? const CircleAvatar(
                      radius: 24,
                      foregroundImage: AssetImage('assets/default_pfp.jpg'),
                    )
                  : CircleAvatar(
                      radius: 24,
                      foregroundImage:
                          MemoryImage(base64Decode(pengguna.foto!)),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengguna.nama,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ulasan['komentar'],
                    maxLines: 10,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.outline),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
