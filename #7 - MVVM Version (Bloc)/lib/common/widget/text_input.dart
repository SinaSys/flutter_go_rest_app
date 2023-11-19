import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.maxLine,
    this.controller,
    this.icon,
    this.focusNode,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    required this.hint,
  });

  final String? initialValue;
  final String hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final Icon? icon;
  final TextEditingController? controller;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.next,
      autovalidateMode: autoValidateMode,
      cursorColor: Colors.grey,
      initialValue: initialValue,
      maxLines: maxLine,
      decoration: InputDecoration(hintText: hint, prefixIcon: icon),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
