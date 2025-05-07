import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class Shadowstyle{
  static final verticalworkshadow = BoxShadow(
    color: primary.c.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset:const Offset(0, 2)
  );


  static final horizondalWorksshadow =BoxShadow(
     color: primary.c.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset:const Offset(0, 2)  
  );
}