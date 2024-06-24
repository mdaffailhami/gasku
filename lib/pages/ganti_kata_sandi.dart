import 'package:flutter/material.dart';

class MyGantiKataSandiPage extends StatefulWidget {
  const MyGantiKataSandiPage({super.key, required this.email});

  final String email;

  @override
  State<MyGantiKataSandiPage> createState() => _MyGantiKataSandiPageState();
}

class _MyGantiKataSandiPageState extends State<MyGantiKataSandiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ganti Kata Sandi',
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
    );
  }
}
