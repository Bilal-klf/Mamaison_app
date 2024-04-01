import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String? errorText;
  final bool obscureText;
  final TextEditingController text ;

  const InputField(
      {super.key,
      required this.icon,
      required this.hint,
      required this.errorText,
      required this.obscureText,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: text,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          errorText: errorText,

          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hint),
    );
  }
}
