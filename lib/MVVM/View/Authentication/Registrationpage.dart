import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/dropdown/custdropdown.dart';
import 'package:swiftclean_project/MVVM/utils/widget/formfield/customformfield.dart';
import 'package:swiftclean_project/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Registrationpage extends StatefulWidget {
  const Registrationpage({super.key});

  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  int selectedIndex = 0;
  bool isUser = true;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? selectedCategory = "";

  final formKey = GlobalKey<FormState>();

  // Controllers for user fields
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  // Controllers for worker fields
  final TextEditingController workerNameController = TextEditingController();
  final TextEditingController workerPhoneController = TextEditingController();
  final TextEditingController workerEmailController = TextEditingController();
  final TextEditingController workerPasswordController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 170,
            child: Column(
              children: [
                ListTile(
                  trailing: const Icon(Icons.cancel),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Choose from Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a Photo"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("New\nAccount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          Column(
            children: [
              GestureDetector(
            onTap: _showImagePicker,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: primary.c,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color.fromRGBO(88, 142, 12, 1), width: 3),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.camera_alt_outlined, size: 38, color: black.c)
                    : null,
              ),
            ),
          ),
          const Text("Upload Picture", style: TextStyle(fontSize: 12, color: Color.fromRGBO(95, 94, 94, 1))),
            ],
          )
            ],
          ),
          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: mq.height * 0.02),
              Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(30),
                child: ToggleSwitch(
                  borderColor: [Colors.white],
                  minWidth: 110.0,
                  minHeight: 45,
                  cornerRadius: 30.0,
                  activeBgColors: [
                    [CustColor.togglevolor1, CustColor.togglevolor2],
                    [CustColor.togglevolor2, CustColor.togglevolor1],
                  ],
                  activeFgColor: CustColor.custwhite,
                  inactiveBgColor: primary.c,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: selectedIndex,
                  totalSwitches: 2,
                  labels: ['User', 'Worker'],
                  fontSize: 18,
                  radiusStyle: true,
                  onToggle: (index) {
                    setState(() {
                      selectedIndex = index!;
                      isUser = (index == 0);
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: isUser ? _buildUserFields() : _buildWorkerFields(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 266,
                height: 60,
                child: Material(
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(40),
                  child: Custombutton(
                    text: Text("Register", style: TextStyle(color: primary.c, fontSize: 20)),
                    onpress: () {
                      if (formKey.currentState!.validate()) {
                        if (isUser) {
                          registerUser();
                        } else {
                          registerWorker();
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUserFields() {
    return [
      _label("Username"),
      _buildFormField("Enter your Username", userNameController),
      _label("Phone"),
      _buildFormField("Enter your Phone", userPhoneController),
      _label("Email"),
      _buildFormField("Enter your Email", userEmailController),
      _label("Password"),
      _buildFormField("Enter your Password", userPasswordController, obscureText: true),
    ];
  }

  List<Widget> _buildWorkerFields() {
    return [
      Custdropdown(
        items: ["Exterior", "Interior", "Vehicle", "Pet", "Home"],
        onchanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
      ),
      const SizedBox(height: 15),
      _label("Username"),
      _buildFormField("Enter your Username", workerNameController),
      _label("Phone"),
      _buildFormField("Enter your Phone", workerPhoneController),
      _label("Email"),
      _buildFormField("Enter your Email", workerEmailController),
      _label("Password"),
      _buildFormField("Enter your Password", workerPasswordController, obscureText: true),
    ];
  }

  Widget _label(String text) {
    return Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(left:  8.0),
      child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ));
  }

  Widget _buildFormField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Customformfield(
        color: formfield.c,
        hinttext: hint,
        hintstyle: TextStyle(color: formletters.c),
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${hint.split("Enter your ").last}';
          }
          if (hint.contains("Email") && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          if (hint.contains("Phone") && !RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
          if (hint.contains("Password") && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          if (hint.contains("Username") && value.length < 3) {
            return 'Username must be at least 3 characters';
          }
          return null;
        },
      ),
    );
  }

  void registerUser() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailController.text.trim(),
        password: userPasswordController.text.trim(),
      );
      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": userNameController.text.trim(),
        "phone": userPhoneController.text.trim(),
        "email": userEmailController.text.trim(),
        "role": "user",
        "profile_img": "",
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp(),
        "status": "active",
        "password":userPasswordController.text.trim(),
        "loyalty_points":0,
      });

      Get.snackbar("Success", "User registered successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.$e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void registerAdmin() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailController.text.trim(),
        password: userPasswordController.text.trim(),
      );
      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("admin").doc(uid).set({
        "username": userNameController.text.trim(),
        "email": userEmailController.text.trim(),
        "role": "admin",
        "profile_img": "",
        "created_at": FieldValue.serverTimestamp(),
        "password":userPasswordController.text.trim(),
      });

      Get.snackbar("Success", "User registered successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.$e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  void registerWorker() async {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      Get.snackbar("Error", "Please select a service category", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: workerEmailController.text.trim(),
        password: workerPasswordController.text.trim(),
      );
      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("workers").doc(uid).set({
        "username": workerNameController.text.trim(),
        "phone": workerPhoneController.text.trim(),
        "email": workerEmailController.text.trim(),
        "role": "worker",
        "category": selectedCategory,
        "profile_img": "",
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp(),
        "status": "pending",
        "services": [],
        "ratings": 0,
        "total_reviews": 0,
        "isVerified":0,
        "password":workerPasswordController.text.trim(),

      });

      Get.snackbar("Success", "Worker registered successfully. Awaiting admin approval.", backgroundColor: Colors.green, colorText: Colors.white);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    String errorMessage = switch (e.code) {
      'weak-password' => 'The password provided is too weak.',
      'email-already-in-use' => 'An account already exists for that email.',
      'invalid-email' => 'Please enter a valid email address.',
      _ => e.message ?? "An unknown error occurred",
    };
    Get.snackbar("Error", errorMessage, backgroundColor: Colors.red, colorText: Colors.white);
  }
}
