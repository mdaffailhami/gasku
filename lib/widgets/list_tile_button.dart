import 'package:flutter/material.dart';

class MyListTileButton extends StatelessWidget {
  const MyListTileButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: Icon(icon, color: Theme.of(context).colorScheme.outline),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).colorScheme.outline,
      ),
      onTap: () => onTap(),
    );
  }
}
