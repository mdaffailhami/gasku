import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.initialValue,
    this.isObscure = false,
    required this.title,
    required this.label,
    this.prefix,
    this.keyboardType,
  });

  final String? initialValue;
  final bool isObscure;
  final String title;
  final String label;
  final Widget? prefix;
  final TextInputType? keyboardType;

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
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          obscureText: widget.isObscure ? _isInvisible : false,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (a) {
            print('SUBMIT');
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            prefix: widget.prefix,
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
