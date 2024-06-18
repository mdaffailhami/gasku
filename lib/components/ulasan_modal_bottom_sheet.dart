import 'package:flutter/material.dart';

class MyUlasanModalBottomSheet extends StatefulWidget {
  const MyUlasanModalBottomSheet({super.key});

  @override
  State<MyUlasanModalBottomSheet> createState() =>
      _MyUlasanModalBottomSheetState();
}

class _MyUlasanModalBottomSheetState extends State<MyUlasanModalBottomSheet> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // height: 300,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Builder(
              builder: (context) {
                final List<Widget> widgets = [];

                for (var i = 1; i <= 5; i++) {
                  widgets.add(
                    IconButton(
                      onPressed: () {
                        setState(() => _rating = i);
                      },
                      icon: Icon(
                        Icons.star,
                        size: 45,
                        color: i <= _rating
                            ? Colors.yellow[700]
                            : Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                );
              },
            ),
            SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                label: Text(
                  'Masukkan Komentar Anda',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: Text(
                  'Kirim Ulasan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
