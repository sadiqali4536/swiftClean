import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/User_edit_address.dart';
import 'package:swiftclean_project/MVVM/View/Screen/Worker/Edit_address.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/card/addresscard.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
        Padding(
          padding: const EdgeInsets.only(top: 35,left: 10),
          child: customBackbutton1(
            onpress: (){
            Navigator.push(
              context,MaterialPageRoute(
              builder:(context)=>Bottomnvigationbar()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50,left: 170),
          child: Text("My Address",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100,left: 20),
          child: SizedBox(
            width: 370,
            height: 160,
            child: Addresscard(
              address: "15/24, Rose Villa\nMG Road, Kochi - 682001\nKerala, India'", 
              onEdit: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context)=>userEditAddress()),
                );
              }),
          ),
        )
        ],
      ),
    );
  }
}