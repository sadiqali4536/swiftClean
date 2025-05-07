import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/servicecard2.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/Scrollable/scrollable_horizontal_buttons.dart';

class ServicesList extends StatefulWidget {
  const ServicesList({super.key});

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size; // FIXED: Defining media query properly
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        title: Row(
          children: [
            customBackbutton1(
              onpress: () {}, // FIXED: Added missing comma
            ),
            SizedBox(width: mq.width * 0.09), // FIXED: Corrected mq usage
            Text(
              "Most Popular Services", // FIXED: Typo in "Services"
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: ScrollableHorizontalButtons(
                categories: [
                  "    All    ",
                  "Exterior",
                  "Interior",
                  "Vehicle ",
                  "     Pet    ",
                  "  Home  "
                ],
                onSelected: (index) {},
              ),
            ),
            Expanded( // FIXED: Ensuring Servicecard2 takes proper space
              child: Servicecard2(), 
            ),
          ],
        ),
      ),
    );
  }
}
