import 'package:flutter/material.dart';

class KontakKamiListTile extends StatelessWidget {
  const KontakKamiListTile({
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
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(body),
        SizedBox(height: 18),
      ],
    );
  }
}
