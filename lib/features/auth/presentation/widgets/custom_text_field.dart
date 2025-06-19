import 'package:auvent_flutter_internship_assessment/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? validation;

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType type;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    required this.type,
    this.validator,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return validation;
            }
            return null;
          },
      keyboardType: type,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: appTheme.color33C4C4C4,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText ?? '',
        prefixIcon: Icon(
            type == TextInputType.emailAddress
                ? Icons.mail_outline
                : Icons.lock_outline,
            color: appTheme.color4D000000),
        hintStyle: TextStyle(color: appTheme.color4D000000),
      ),
      style: TextStyle(color: appTheme.color4D000000),
    );
  }
}
