import 'package:flutter/material.dart';

import 'label.dart';

class DropDown<T> extends StatelessWidget {
  const DropDown({
    Key? key,
    required this.label,
    required this.items,
    this.hintText,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InputLabel(label),
        ),
        DropdownButtonFormField<T>(
          items: items
              .map(
                (type) => DropdownMenuItem<T>(
                  child: Text('$type'),
                  value: type,
                ),
              )
              .toList(),
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText ?? 'Select $label',
          ),
        ),
      ],
    );
  }
}
