import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/formfield/customformfield.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

void _showImagePicker() {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top indicator
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 186, 185, 185),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Camera & Gallery Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                          child: Image.asset("assets/icons/camera.png", height: 40),
                        ),
                        const SizedBox(height: 8),
                        const Text("Camera"),
                      ],
                    ),
                  ),
                  // Gallery
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                          child: Image.asset("assets/icons/gallery.png", height: 50),
                        ),
                        const SizedBox(height: 8),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Cancel Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 232, 232),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),

              const SizedBox(height: 10),

              // Remove Image Option
              if (_image != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text("Remove Profile Picture"),
                  onTap: () {
                    setState(() {
                      _image = null;
                    });
                    Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 208, 208),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, left: 180),
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: customBackbutton1(
              onpress: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => Bottomnvigationbar()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 146),
            child: Container(
              height: 750,
              width: 420,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: const Center(
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 160),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(),
                color: const Color.fromARGB(255, 227, 227, 227),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.person, size: 44, color: Colors.black)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210,left: 25),
            child: Text("First name",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold,
              color: Color.fromRGBO(196, 198, 200, 1)),),
          ),
           Padding(
                    padding: const EdgeInsets.only(top: 230,left: 30),
                    child: Customformfield(
                      color: Colors.white, 
                      hinttext: "First User Name", 
                      hintstyle: TextStyle(color: Colors.black)),
                  ),
         Padding(
            padding: const EdgeInsets.only(top: 290,left: 25),
            child: Text("Last name",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold,
              color: Color.fromRGBO(196, 198, 200, 1)),),
          ),
           Padding(
                    padding: const EdgeInsets.only(top: 310,left: 30),
                    child: Customformfield(
                      color: Colors.white, 
                      hinttext: "Last User Name", 
                      hintstyle: TextStyle(color: Colors.black)),
                  ),
            Padding(
            padding: const EdgeInsets.only(top: 370,left: 25),
            child: Text("Email",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold,
              color: Color.fromRGBO(196, 198, 200, 1)),),
          ),
           Padding(
                    padding: const EdgeInsets.only(top: 390,left: 30),
                    child: Customformfield(
                      color: Colors.white, 
                      hinttext: "Example @gmail.com", 
                      hintstyle: TextStyle(color: Colors.black)),
                  ),
                  Padding(
            padding: const EdgeInsets.only(top: 455,left: 25),
            child: Text("Phone",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold,
              color: Color.fromRGBO(196, 198, 200, 1)),),
          ),
           Padding(
                    padding: const EdgeInsets.only(top: 480,left: 30),
                    child: Customformfield(
                      color: Colors.white, 
                      hinttext: "+91 23456789", 
                      hintstyle: TextStyle(color: Colors.black)),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 690),
                      child: SizedBox(
                        height: 46,
                        width: 350,
                        child: Custombutton(
                          text: Text("Update",
                          style: TextStyle(color: Colors.white),), 
                          onpress: (){}),
                      ),
                    ),
                  )
        ],
      ),
    );
  }
}
