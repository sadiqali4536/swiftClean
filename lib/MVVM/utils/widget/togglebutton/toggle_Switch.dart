import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomToggleSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,                  // Thumb color ON
      activeTrackColor: Color(0xFF06C729),        // Green background ON
      inactiveThumbColor: Colors.white,           // Thumb color OFF
      inactiveTrackColor: Colors.black,           // Black background OFF
    );
  }
}