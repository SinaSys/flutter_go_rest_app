import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key,
      this.initialValue,
      this.onChanged,
      this.validator,
      this.maxLine,
      required this.hint})
      : super(key: key);

  final String? initialValue;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.grey,
      initialValue: initialValue,
      maxLines: maxLine,
      decoration: InputDecoration(hintText: hint),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
