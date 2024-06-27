import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/pages/detail_pangkalan.dart';
import 'package:gasku/utils/format_rupiah.dart';

class MyPangkalanCard extends StatelessWidget {
  const MyPangkalanCard({super.key, required this.pangkalan});

  final Pangkalan pangkalan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyDetailPangkalanPage(pangkalan: pangkalan),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: pangkalan.foto.isEmpty
                        ? Image.asset(
                            'assets/gasku_logo.png',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            base64Decode(pangkalan.foto[0]),
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pangkalan.nama,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        pangkalan.alamat,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 20,
                          ),
                          SizedBox(width: 3),
                          Text(
                            pangkalan.ratingAverage.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: 'Rp',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: formatRupiah(pangkalan.harga),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
