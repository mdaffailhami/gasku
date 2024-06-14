import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: 12,
      indent: 12,
      height: 1,
    );
  }
}
