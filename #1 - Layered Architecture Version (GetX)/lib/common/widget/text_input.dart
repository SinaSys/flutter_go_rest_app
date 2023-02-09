import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    this.initialValue,
    this.onChanged,
    this.validator,
    this.maxLine,
    this.controller,
    this.icon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    required this.hint,
    Key? key,
  }) : super(key: key);

  final String? initialValue;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final Icon? icon;
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      autovalidateMode: autovalidateMode,
      cursorColor: Colors.grey,
      initialValue: initialValue,
      maxLines: maxLine,
      decoration: InputDecoration(hintText: hint, prefixIcon: icon),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
