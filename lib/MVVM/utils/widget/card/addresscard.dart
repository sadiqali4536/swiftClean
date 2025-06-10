import 'package:flutter/material.dart';

class Addresscard extends StatelessWidget {
  final String address;
  final VoidCallback ?onEdit;

  const Addresscard({
    super.key,
   required this.address, 
   this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [ 
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 30),
            child: Text(
              address,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onEdit, 
              icon: Image.asset("assets/icons/edit.png")))
        ],
      ),
    );
  }
}