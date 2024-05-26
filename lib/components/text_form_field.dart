import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.isObscure = false,
    required this.title,
    required this.label,
  });

  final bool isObscure;
  final String title;
  final String label;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  var _isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 23),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 7),
        TextFormField(
          obscureText: widget.isObscure ? _isInvisible : false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            suffixIcon: widget.isObscure
                ? IconButton(
                    onPressed: () {
                      setState(() => _isInvisible = !_isInvisible);
                    },
                    icon: _isInvisible
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
