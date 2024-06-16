import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  const MyComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CircleAvatar(
            foregroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/74972129?v=4',
            ),
            radius: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Muhammad Daffa Ilhami',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi maxime quam, sit fugiat veritatis animi? Et at odit modi nihil. Cumque dignissimos accusamus laboriosam ipsam ab quisquam iste impedit enim?',
                maxLines: 10,
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
