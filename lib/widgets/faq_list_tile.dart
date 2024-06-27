import 'package:flutter/material.dart';

class MyFAQListTile extends StatelessWidget {
  const MyFAQListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final String? title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        Text(body),
        const SizedBox(height: 20),
      ],
    );
  }
}
