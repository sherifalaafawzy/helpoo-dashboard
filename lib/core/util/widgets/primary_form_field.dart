import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class PrimaryFormField extends StatelessWidget {
  final String validationError;
  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isPassword;
  final GestureTapCallback? onTap;
  final bool enabled;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool infiniteLines;
  final bool isValidate;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const PrimaryFormField({
    super.key,
    required this.validationError,
    required this.label,
    this.controller,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.onTap,
    this.initialValue,
    this.enabled = true,
    this.suffixIcon,
    this.infiniteLines = false,
    this.isValidate = true,
    this.onChange,
    this.inputFormatters,
    this.textAlign ,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      onTap: onTap,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection ?? TextDirection.ltr,
      validator: isValidate
          ? (value) {
              if (value!.isEmpty) {
                return validationError;
              }
              return null;
            }
          : null,
      controller: controller,
      obscureText: isPassword,
      maxLines: infiniteLines ? null : 1,
      onChanged: onChange,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: suffixIcon,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderGrey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderGrey,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderGrey,
          ),
        ),
      ),
    );
  }
}
