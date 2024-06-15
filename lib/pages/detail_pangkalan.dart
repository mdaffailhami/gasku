import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gasku/widgets/comment.dart';
import 'package:gasku/widgets/divider.dart';
import 'package:gasku/widgets/filled_button.dart';
import 'package:gasku/widgets/icon_filled_button.dart';

class MyDetailPangkalanPage extends StatelessWidget {
  const MyDetailPangkalanPage({super.key});

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
                enableInfiniteScroll: true,
                padEnds: false,
                viewportFraction: 1,
                autoPlay: true,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(),
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      'assets/gasku_logo.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
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
                    'Pangkalan LPG Rahmi',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Jl. Sultan Adam Komplek Mekar Sari Blok 24B, No.52',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Rp',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: '23.000',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: MyIconFilledButton(
                          icon: Icons.message_outlined,
                          label: 'Chat',
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: MyIconFilledButton(
                          icon: Icons.pin_drop_outlined,
                          label: 'Maps',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 6),
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
                      SizedBox(width: 6),
                      Text(
                        '+62 123456789',
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
                      SizedBox(width: 6),
                      Text(
                        'pangkalanrahmi332@gmail.com',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
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
                              final int totalStar = 4;
                              final List<Icon> widgets = [];

                              for (int i = 0; i < totalStar; i++) {
                                widgets.add(
                                  Icon(Icons.star, color: Colors.yellow[700]),
                                );
                              }

                              return Row(children: widgets);
                            },
                          ),
                          Text(
                            '(23 ulasan)',
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
                      Spacer(),
                      MyIconFilledButton(
                        icon: Icons.add,
                        label: 'Beri Ulasan',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  MyComment(),
                  MyDivider(height: 20),
                  MyComment(),
                  MyDivider(height: 20),
                  MyComment(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
