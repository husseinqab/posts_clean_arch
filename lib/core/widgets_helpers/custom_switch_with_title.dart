import 'package:flutter/material.dart';

class SwitchWithTitle extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String title;

  const SwitchWithTitle(
      {Key? key,
        required this.value,
        required this.onChanged,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(activeColor: Colors.green, value: value, onChanged: onChanged),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}