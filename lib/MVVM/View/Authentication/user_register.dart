import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/formfield/customformfield.dart';

class UserRegister extends StatelessWidget {
   UserRegister({super.key});

   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UserName'),
          Customformfield(color: formfield.c, hinttext: 'Name', hintstyle: TextStyle()),
          Customformfield(color: formfield.c, hinttext: 'Name', hintstyle: TextStyle()),
          Customformfield(color: formfield.c, hinttext: 'Name', hintstyle: TextStyle()),
          Customformfield(color: formfield.c, hinttext: 'Name', hintstyle: TextStyle()),
          Customformfield(color: formfield.c, hinttext: 'Name', hintstyle: TextStyle()),
          Align(
            // alignment: Al,
            child: SizedBox(width: 266,
                          height: 60,
                   child: Material(
                    elevation: 10,
                            shadowColor: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                     child: Custombutton(
                      onpress: (){},
                       text: Text("Register", style: TextStyle(color: primary.c, fontSize: 20)),
                      //  onpress: 
                     ),
                   ),
                 ),
          ),
        ],
      ),
    );
  }
}