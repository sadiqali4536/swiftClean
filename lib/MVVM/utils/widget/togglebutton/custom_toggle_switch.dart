import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final int initialIndex;
  final int totalSwitches;
  final double width;
  final double height;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final double elevation;
  final double borderRadius;
  final Function(int) onToggle;

  const CustomToggleSwitch({
    super.key,
    required this.totalSwitches,
    required this.onToggle,
    this.initialIndex = 0,
    this.width = 40,
    this.height = 5,
    this.activeBgColor = const Color.fromARGB(255, 56, 122, 2),
    this.inactiveBgColor = Colors.white,
    this.elevation = 15,
    this.borderRadius = 30,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: widget.elevation,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.inactiveBgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: List.generate(widget.totalSwitches, (index) {
              bool isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onToggle(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.activeBgColor
                          : widget.inactiveBgColor,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
