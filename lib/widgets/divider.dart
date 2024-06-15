import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.height, this.indent, this.endIndent});

  final double? height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: endIndent,
      indent: indent,
      height: height,
    );
  }
}
