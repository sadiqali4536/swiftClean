

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftclean_project/MVVM/model/models/cart_model.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';

class Dropdown2 extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String hint;
  final ValueChanged<String?> onChanged;

  const Dropdown2({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        hint: Text(hint),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
      ),
    );
  }
}

class VehicleBookingPage extends StatefulWidget {
   final String ?serviceId;
  const VehicleBookingPage({super.key, this.serviceId});

  @override
  State<VehicleBookingPage> createState() => _VehicleBookingPageState();
}

class _VehicleBookingPageState extends State<VehicleBookingPage> {
  int selectedIndex = 0;
  DateTime selectedDate = DateTime.now();
  int hour = 10;
  int minute = 30;
  String meridiem = 'AM';

  String? selectedVehicle;
  String? selectedCategory;
  String? selectedCleaningType;

  final Map<String, List<String>> vehicleCategories = {
    'Car': ['Hatchback', 'Sedan', 'SUV'],
    'Bike': ['Scooter', 'Motorcycle'],
    'Truck': ['Mini Truck', 'Pickup'],
  };

  List<DateTime> getWeekDates() {
    final now = DateTime.now();
    return List.generate(7, (index) => now.add(Duration(days: index)));
  }

  String _getMonthName(int month) {
    return DateFormat.MMM().format(DateTime(0, month));
  }

  void incrementHour() {
    setState(() {
      hour = (hour % 12) + 1;
    });
  }

  void decrementHour() {
    setState(() {
      hour = (hour == 1) ? 12 : hour - 1;
    });
  }

  void incrementMinute() {
    setState(() {
      minute += 5;
      if (minute >= 60) {
        minute = 0;
        incrementHour();
      }
    });
  }

  void decrementMinute() {
    setState(() {
      minute -= 5;
      if (minute < 0) {
        minute = 55;
        decrementHour();
      }
    });
  }

  void toggleMeridiem(String value) {
    setState(() {
      meridiem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.asset(
                    "assets/image/vehicle_Booking_page.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 250, 249, 249),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Select Custom Vehicle Cleaning",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                       const SizedBox(height: 15),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            _cleaningTypeButton("Exterior Wash"),
                            _cleaningTypeButton("Interior Cleaning"),
                            _cleaningTypeButton("Engine Cleaning"),
                            _cleaningTypeButton("Glass Cleaning"),
                            _cleaningTypeButton("Upholstery Cleaning"),
                            _cleaningTypeButton("Wheel and Tire Cleaning"),
                          ].expand((w) => [w, const SizedBox(width: 5)]).toList(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Select Date",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: getWeekDates().length,
                          itemBuilder: (context, index) {
                            final date = getWeekDates()[index];
                            final isSelected = index == selectedIndex;
                            final monthName = _getMonthName(date.month);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedDate = date;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? gradientgreen1.c
                                      : const Color.fromRGBO(229, 229, 229, 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(DateFormat.E().format(date),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black)),
                                    const SizedBox(height: 5),
                                    Text('${date.day}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black)),
                                    const SizedBox(height: 5),
                                    Text(monthName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Dropdown2(
                                items: vehicleCategories.keys.toList(),
                                selectedValue: selectedVehicle,
                                hint: 'Vehicle Type',
                                onChanged: (value) {
                                  setState(() {
                                    selectedVehicle = value;
                                    selectedCategory = null;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (selectedVehicle != null)
                              Expanded(
                                child: Dropdown2(
                                  items: vehicleCategories[selectedVehicle]!,
                                  selectedValue: selectedCategory,
                                  hint: 'Category',
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Select Time",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _timeUnitColumn(
                            value: hour.toString().padLeft(2, '0'),
                            onIncrement: incrementHour,
                            onDecrement: decrementHour,
                          ),
                          const SizedBox(width: 10),
                          const Text(":", style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 10),
                          _timeUnitColumn(
                            value: minute.toString().padLeft(2, '0'),
                            onIncrement: incrementMinute,
                            onDecrement: decrementMinute,
                          ),
                          const SizedBox(width: 20),
                          _meridiemButton("AM"),
                          const SizedBox(width: 10),
                          _meridiemButton("PM"),
                        ],
                      ),
                      const SizedBox(height: 128),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 10,
              top: 40,
              child: customBackbutton1(
                onpress: () => Navigator.pop(context),
              ),
            ),

              Positioned(
                      top: 320,
                      left: 320,
                      child: IconButton(
                       onPressed: () async {
                        
                          ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Added to cart')),
                        );
                     },
                        icon:Icon(Icons.add_shopping_cart_outlined)),
                    ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Image.asset("assets/icons/dollar.png", scale: 2),
            const SizedBox(width: 10),
            const Text("Price", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            const Text("/Day", style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              height: 57,
              width: 160,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gradientgreen2.c),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        "Selected: ${selectedCleaningTypes.join(',')}|$selectedCategory|$selectedDate",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
                child: const Text("Book Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
 Set<String> selectedCleaningTypes = {};
  Widget _cleaningTypeButton(String label) {
    final bool isSelected = selectedCleaningTypes.contains(label);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? gradientgreen2.c : const Color(0xFFE7E7E7),
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: () {
        setState(() {
          if(isSelected){
            selectedCleaningTypes.remove(label);
          } else {
            selectedCleaningTypes.add(label);
          }
        });
      },
      child: Text(label),
    );
  }

  Widget _timeUnitColumn({
    required String value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      children: [
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(30),
          child: IconButton(
            icon: const Icon(Icons.add),
            color: gradientgreen2.c,
            onPressed: onIncrement,
          ),
        ),
        const SizedBox(height: 15),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
            ),
            child: Text(value, style: const TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(height: 15),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(30),
          child: IconButton(
            icon: const Icon(Icons.remove),
            color: gradientgreen2.c,
            onPressed: onDecrement,
          ),
        ),
      ],
    );
  }

  Widget _meridiemButton(String value) {
    final bool isSelected = meridiem == value;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? gradientgreen2.c : const Color(0xFFE7E7E7),
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(52, 42),
      ),
      onPressed: () => toggleMeridiem(value),
      child: Text(value),
    );
  }
}
