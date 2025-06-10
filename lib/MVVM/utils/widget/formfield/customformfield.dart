import 'package:flutter/material.dart';

class Customformfield extends StatefulWidget {
  final Color color;
  final String hinttext;
  final TextStyle hintstyle;
  final String? helpertext;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final Widget? icon;
  final Function()? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const Customformfield({
    super.key,
    required this.color,
    required this.hinttext,
    required this.hintstyle,
    this.helpertext,
    this.prefixicon,
    this.suffixicon,
    this.icon,
    this.suffix,
    this.controller,
    this.obscureText = false,
    this.validator, String? Function(dynamic Value)? Validator,
  });

  @override
  State<Customformfield> createState() => _CustomformfieldState();
}

class _CustomformfieldState extends State<Customformfield> {
  bool _obscureText = true; 

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 380,height: 70,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText, 
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: widget.color,
          filled: true,
          hintText: widget.hinttext,
          hintStyle: widget.hintstyle,
          helperText: widget.helpertext,
          prefixIcon: widget.prefixicon,
          suffixIcon: widget.suffixicon,     
        ),
      ),
    );
  }
}
