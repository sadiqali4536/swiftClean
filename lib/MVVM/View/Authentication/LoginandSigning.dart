import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Forget_password.dart';
import 'package:swiftclean_project/MVVM/View/Authentication/Registrationpage.dart';
import 'package:swiftclean_project/MVVM/model/services/firebaseauthservices.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/formfield/customformfield.dart';

class LoginAndSigning extends StatefulWidget {
  const LoginAndSigning({super.key});

  @override
  State<LoginAndSigning> createState() => _LoginAndSigningState();
}

class _LoginAndSigningState extends State<LoginAndSigning> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController2 = TextEditingController();
  final formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
            alignment: Alignment.center,
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  "assets/image/UserLoginSignin.png",
                  fit: BoxFit.cover,
                ),
              ),
          
              // Logo & Branding
          Positioned(
            top: 20,
            left: 290,
            child: Image.asset("assets/icons/logo2.png",height: 70,width: 70,)
            ),
              
              Positioned(
            top: 50,
            left: 250,
            child: Image.asset("assets/icons/SWIFT.png",height: 70,width: 70,)
            ),
          
            Positioned(
            top: 50,
            left: 320,
            child: Image.asset("assets/icons/CLEAN.png",height: 70,width: 70,)
            ),
          
              // Tagline
              Positioned(
                top: mq.height * 0.36,
                left: mq.width * 0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your One-Stop Solution for All",
                      style: TextStyle(color: primary.c ?? Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Cleaning Needs!",
                      style: TextStyle(color: primary.c ?? Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
          
              // Sign In & Sign Up Buttons
              Positioned(
                top: mq.height * 0.65,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 230,
                      child: Custombutton(
                        text: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: primary.c),
                        ),
                        onpress: () => _showCustomBottomSheet(context, mq),
                      ),
                    ),
                    SizedBox(height: 70),
                    SizedBox(
                      height: 60,
                      width: 230,
                      child: Custombutton(
                        text: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: primary.c),
                        ),
                        onpress: () => _showCustomBottomSheet2(context,mq), 
                          // Navigate to Sign Up Page
                         
                      ),
                    ),
                  ],
                ),
              ),
            ],
    )
    );
  }

  // custom bottomsheet for login
  void _showCustomBottomSheet(BuildContext context, Size mq) {
    showModalBottomSheet(
      backgroundColor: const Color.fromRGBO(241, 242, 243, 1),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          controller: ScrollController(),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: mq.height * 0.64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Indicator
                  SizedBox(height: 13,),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // Welcome Text
                  Center(
                    child: Text(
                      "Welcome back",
                      style: TextStyle(
                        color: black.c ?? Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  // Email Field
                  Padding(
                    padding: EdgeInsets.only(left:mq.width*0.10 ),
                    child: const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                   const SizedBox(height: 5),
                  Center(
                    child: SizedBox(width: 360,
                      child: Customformfield( 
                        color: formfield.c,
                        hinttext: "Enter your Email Address",
                        hintstyle: TextStyle(color: formletters.c),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Email Address";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        controller: _emailController, 
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 15),
              
                  // Password Field
                  Padding(
                    padding:  EdgeInsets.only(left:mq.width*0.10),
                    child: const Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                   const SizedBox(height: 5),
                  Center(
                    child: SizedBox(width: 360,
                      child: Customformfield(
                        color: formfield.c,
                        hinttext: "Enter your Password",
                        hintstyle: TextStyle(color: formletters.c),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        controller: _passwordController,
                      ),
                    ),
                  ),
                  // Forgot Password
                  Align(
                      alignment: Alignment.centerRight, 
                      child: Padding(
                      padding: const EdgeInsets.only(right: 20), 
                      child: GestureDetector(
                     onTap: () {
                           },
                      child: Text(
                                "Forgot Password?",
                                  style: TextStyle(
                                   color: gradientgreen2.c ?? const Color.fromARGB(255, 92, 3, 98),
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16,
                                 ),
                                ),
                              ),
                            ),
                          ),

                 const SizedBox(height: 25),
              
                  // Sign In Button
                  Center(
                    child: SizedBox(
                      height: 60,
                      width: 226,
                      child: Material(
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(40),
                        child: Custombutton(
                          text: Text(
                            "Sign In",
                            style: TextStyle(color: primary.c ?? Colors.white, fontSize: 20),
                          ),
                          onpress: () {
                            if(formKey.currentState!.validate()){
                              
                            }
                            
                          },
                        ),
                      ),
                    ),
                  ),
                           const SizedBox(height:3),
                  Center(child: 
                  Text("Or Sign in with",style: TextStyle(color: Color.fromRGBO(133, 130, 130, 1)),)),
                  SizedBox(height:mq.height*0.03,),
                  Center(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        GestureDetector(
                          onTap: () {
                          FirebaseAuthServices().signInWithGoogle().then((value){
                              print(value);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(value)));
                            }); 
                          },
                          child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/icons/google_logo.png")),
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        ),
                      SizedBox(width: mq.width*0.05,),
                      GestureDetector(
                        onTap: (){
                            //email
                        },
                        child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/icons/gmail-logo.png")),
                          borderRadius: BorderRadius.circular(20)
                        ),
                                            ),
                      )
                      ]
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


  void _showForgetPassword(BuildContext context, Size mq) {
  showModalBottomSheet(
    context: context, 
    builder: (BuildContext context) { 
      return Padding(
        padding: EdgeInsets.only(),
        child: ForgetPassword(),);
     });}

//custom bottomsheet for registration
void _showCustomBottomSheet2(BuildContext context, Size mq) {
  showModalBottomSheet(
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
    ),
    backgroundColor: const Color.fromRGBO(241, 242, 243, 1),
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet( 
        expand: false,
        initialChildSize: 0.6, 
        minChildSize: 0.4, 
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
           child: SingleChildScrollView(
            controller: scrollController,
            child: Registrationpage(),
           ),
          );
        },
      );
    },
  );
}
