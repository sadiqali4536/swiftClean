import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

class Custombutton extends StatelessWidget {
  final VoidCallback onpress;
  final Widget text;

  const Custombutton({super.key,
    required this.text,
     required this.onpress, 
  });
  @override
  Widget build(BuildContext context) {
    return Container(decoration: 
    BoxDecoration(
      gradient: LinearGradient(colors:[
        gradientgreen1.c,
        gradientgreen2.c,
        gradientgreen3.c,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(40),
    ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor:Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          ),
           onPressed: onpress,
           child: text,
      ),
    );
  }
}
