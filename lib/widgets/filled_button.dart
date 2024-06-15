import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  const MyFilledButton({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(text),
      ),
    );
  }
}
