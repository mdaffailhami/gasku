import 'package:flutter/material.dart';

class MyPengajuanPangkalanListTile extends StatelessWidget {
  const MyPengajuanPangkalanListTile({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(body),
        const SizedBox(height: 25),
      ],
    );
  }
}
