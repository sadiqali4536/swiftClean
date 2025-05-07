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

  String? selectedValue = "";

  final formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _usercontrollers = {
    'username': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  final Map<String, TextEditingController> _workercontrollers = {
    'username': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

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
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: mq.height * 0.01, left: mq.width * 0.36),
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * 0.04, left: mq.width * 0.06),
            child: const Text("New ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * 0.08, left: mq.width * 0.06),
            child: const Text("Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * 0.05, left: mq.width * 0.62),
            child: GestureDetector(
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
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height * 0.12, left: mq.width * 0.60),
            child: const Text("Upload Picture", style: TextStyle(fontSize: 12, color: Color.fromRGBO(95, 94, 94, 1))),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: mq.height * 0.16),
              Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(30),
                child: ToggleSwitch(
                  borderColor: [const Color.fromARGB(255, 248, 246, 246)],
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
                          userRegister(_usercontrollers);
                        } else {
                          workerRegister(_workercontrollers);
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
      _buildCustomFormField('Enter your Username', _usercontrollers),
      _label("Phone"),
      _buildCustomFormField('Enter your Phone', _usercontrollers),
      _label("Email"),
      _buildCustomFormField('Enter your Email', _usercontrollers),
      _label("Password"),
      _buildCustomFormField('Enter your Password', _usercontrollers, obscureText: true),
    ];
  }

  List<Widget> _buildWorkerFields() {
    return [
      _buildDropdown(),
      const SizedBox(height: 15),
      _label("Username"),
      _buildCustomFormField('Enter your Username', _workercontrollers),
      _label("Phone"),
      _buildCustomFormField('Enter your Phone', _workercontrollers),
      _label("Email"),
      _buildCustomFormField('Enter your Email', _workercontrollers),
      _label("Password"),
      _buildCustomFormField('Enter your Password', _workercontrollers, obscureText: true),
    ];
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(right: mq.width * 0.5),
      child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCustomFormField(String hintText, Map<String, TextEditingController> controllers, {bool obscureText = false}) {
    String fieldName = hintText.split('Enter your ').last.toLowerCase();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Customformfield(
        color: formfield.c,
        hinttext: hintText,
        hintstyle: TextStyle(color: formletters.c),
        controller: controllers[fieldName],
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $fieldName';
          }
          switch (fieldName) {
            case 'email':
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              break;
            case 'phone':
              if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
              break;
            case 'password':
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              break;
            case 'username':
              if (value.length < 3) {
                return 'Username must be at least 3 characters';
              }
              break;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
    return Custdropdown(
      items: ["Exterior", "Interior", "Vehicle", "Pet", "Home"],
      onchanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }

  void userRegister(Map<String, TextEditingController> controllers) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllers['email']!.text.trim(),
        password: controllers['password']!.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": controllers["username"]!.text.trim(),
        "phone": controllers["phone"]!.text.trim(),
        "email": controllers["email"]!.text.trim(),
        "role": "user",
        "profile_img": "",
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp(),
        "status": "active"
      });

      Get.snackbar("Success", "User registered successfully", backgroundColor: Colors.green, colorText: Colors.white);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void workerRegister(Map<String, TextEditingController> controllers) async {
    try {
      // if (_image == null) {
      //   Get.snackbar("Error", "Please select a profile image", backgroundColor: Colors.red, colorText: Colors.white);
      //   return;
      // }

      if (selectedValue!.isEmpty) {
        Get.snackbar("Error", "Please select a service category", backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllers['email']!.text.trim(),
        password: controllers['password']!.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": controllers["username"]!.text.trim(),
        "phone": controllers["phone"]!.text.trim(),
        "email": controllers["email"]!.text.trim(),
        "role": "worker",
        "category": selectedValue,
        "profile_img": "",
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp(),
        "status": "pending",
        "services": [],
        "ratings": 0,
        "total_reviews": 0,
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
