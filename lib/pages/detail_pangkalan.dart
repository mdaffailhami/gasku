import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gasku/components/laporan_modal_bottom_sheet.dart';
import 'package:gasku/components/ulasan_modal_bottom_sheet.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/utils/format_rupiah.dart';
import 'package:gasku/utils/open_link.dart';
import 'package:gasku/widgets/comment_list_tile.dart';
import 'package:gasku/widgets/divider.dart';
import 'package:gasku/widgets/icon_filled_button.dart';

class MyDetailPangkalanPage extends StatelessWidget {
  const MyDetailPangkalanPage({super.key, required this.pangkalan});

  final Pangkalan pangkalan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Pangkalan',
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
        child: Column(
          children: [
            FlutterCarousel(
              options: CarouselOptions(
                height: 210,
                enableInfiniteScroll: false,
                padEnds: false,
                viewportFraction: 1,
                autoPlay: true,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(),
              ),
              items: pangkalan.foto.isEmpty
                  ? [
                      Image.asset(
                        'assets/gasku_logo.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    ]
                  : pangkalan.foto.map((foto) {
                      return Image.memory(
                        base64Decode(foto),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pangkalan.nama,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    pangkalan.alamat,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Rp',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: formatRupiah(pangkalan.harga),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: MyIconFilledButton(
                          icon: Icons.message_outlined,
                          label: 'Chat',
                          color: Colors.green,
                          onPressed: () {
                            try {
                              openLink('https://wa.me/62${pangkalan.telepon}');
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                action: SnackBarAction(
                                  label: 'Tutup',
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar(),
                                ),
                              ));
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: MyIconFilledButton(
                          icon: Icons.pin_drop_outlined,
                          label: 'Maps',
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            try {
                              openLink(pangkalan.gmap);
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                action: SnackBarAction(
                                  label: 'Tutup',
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar(),
                                ),
                              ));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 26, bottom: 6),
                    child: Text(
                      'Kontak',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.call,
                        size: 20,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '+62 ${pangkalan.telepon}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        pangkalan.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return MyLaporanModalBottomSheet(
                            pangkalan: pangkalan,
                          );
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      overlayColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      'Laporkan Pangkalan',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Komentar',
                    style: TextStyle(fontSize: 19),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              final double ratingAverage =
                                  pangkalan.ratingAverage;

                              final int totalStar = ratingAverage.floor();
                              final List<Widget> widgets = [];

                              for (int i = 0; i < totalStar; i++) {
                                widgets.add(
                                  Icon(Icons.star, color: Colors.yellow[700]),
                                );
                              }

                              widgets.add(
                                Text(
                                  ratingAverage == 0
                                      ? '0'
                                      : ratingAverage.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                              );

                              return Row(children: widgets);
                            },
                          ),
                          Text(
                            '(${pangkalan.ulasan.length} ulasan)',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      MyIconFilledButton(
                        icon: Icons.add,
                        label: 'Beri Ulasan',
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return MyUlasanModalBottomSheet(
                                pangkalan: pangkalan,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (var ulasan in pangkalan.ulasan) ...[
                    MyCommentListTile(ulasan: ulasan),
                    const MyDivider(height: 20),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
