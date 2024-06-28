import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasku/cubits/daftar_pangkalan.dart';
import 'package:gasku/cubits/pengguna_masuk.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/models/pengguna.dart';
import 'package:gasku/pages/detail_pangkalan.dart';
import 'package:gasku/utils/show_loading_screen.dart';

class MyUlasanModalBottomSheet extends StatefulWidget {
  const MyUlasanModalBottomSheet({super.key, required this.pangkalan});

  final Pangkalan pangkalan;

  @override
  State<MyUlasanModalBottomSheet> createState() =>
      _MyUlasanModalBottomSheetState();
}

class _MyUlasanModalBottomSheetState extends State<MyUlasanModalBottomSheet> {
  int _rating = 0;
  String _komentar = '';

  Future<void> _onSubmit() async {
    showLoadingScreen(context);

    final Pengguna pengguna = context.read<PenggunaMasukCubit>().state!;

    widget.pangkalan.ulasan.add({
      'nik': pengguna.nik,
      'rating': _rating,
      'komentar': _komentar,
    });

    try {
      await Pangkalan.updateOnly(
        widget.pangkalan.id!,
        {'ulasan': widget.pangkalan.ulasan},
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              MyDetailPangkalanPage(pangkalan: widget.pangkalan),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ulasan terkirim'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // height: 300,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (value) => _komentar = value,
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
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => _onSubmit(),
                child: const Text(
                  'Kirim Ulasan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
