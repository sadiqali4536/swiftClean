import 'package:flutter/material.dart';

class Dropdown2 extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String hint;
  final ValueChanged<String?> onChanged;

  const Dropdown2({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
  });

  

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 45,
        width: 140,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: items.contains(selectedValue) ? selectedValue : null,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 99, 99, 99)),
            ),
            icon: Icon(Icons.arrow_drop_down, size: 36,color: const Color.fromARGB(255, 9, 9, 9)),
            iconDisabledColor: Colors.black,
            
            dropdownColor: Colors.white,
            isExpanded: true,
            alignment: Alignment.centerLeft,
            onChanged: onChanged,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                 style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
