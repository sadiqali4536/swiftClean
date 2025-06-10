import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/widget/containner/custom_image_banner2.dart';

class CustomImageBanner extends StatelessWidget {
  const CustomImageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 110,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 237, 237, 237)),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("0",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text("Loyalty Points",style: TextStyle(
                  fontSize: 12,color: Color.fromRGBO(165, 165, 169, 1)
                ),),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(88, 142, 12, 0.25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(88, 142, 12, 1),
                            Color.fromRGBO(53, 120, 1, 1),
                          ],
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset("assets/icons/star.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
