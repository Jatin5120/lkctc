import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';
import 'label.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.label,
    required this.controller,
    this.hint,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.floatingLabel = false,
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onChanged,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.words,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool floatingLabel;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: !floatingLabel ? 0 : size.height.twoPercent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!floatingLabel && label != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InputLabel(label!),
            ),
          ] else ...[
            const SizedBox(height: 16),
          ],
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              label: floatingLabel && label != null ? Text(label!) : null,
              hintText: hint,
              prefix: prefix,
              prefixIcon: prefixIcon,
              suffix: suffix,
              suffixIcon: suffixIcon,
              counterText: '',
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
