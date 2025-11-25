import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/servicecard2.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/Scrollable/scrollable_horizontal_buttons.dart';

class ServicesList extends StatefulWidget {
  const ServicesList({super.key});

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  int selectedCategoryIndex = 0;

  final List<String> categoryList = [
    "All", "Exterior", "Interior", "Vehicle", "Pet", "Home"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Most Popular Services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ScrollableHorizontalButtons(
              categories: categoryList,
              selectedIndex: selectedCategoryIndex,
              onSelected: (index) {
                setState(() => selectedCategoryIndex = index);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Servicecard2(
                category: categoryList[selectedCategoryIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}