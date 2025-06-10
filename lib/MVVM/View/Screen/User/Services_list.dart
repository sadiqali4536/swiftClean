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
  int selectedIndex = 0;
  int selectedCategoryIndex = 0;
 final List<String> categoryList = ["All", "Exterior", "Interior", "Vehicle", "Pet", "Home"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Text(
                "Most Popular Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollableHorizontalButtons(
                              categories: categoryList,
                              selectedIndex: selectedCategoryIndex,
                              onSelected: (index) {
                                setState(() => selectedCategoryIndex = index);
                              },
                            ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Servicecard2(
               
              ),
            ),
          ],
        ),
      ),
    );
  }
}
