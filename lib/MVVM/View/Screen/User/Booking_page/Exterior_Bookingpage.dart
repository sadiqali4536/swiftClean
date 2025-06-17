import 'dart:convert'; // Not strictly needed for this corrected code, but kept as it was in original.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cartItemsCollectionRef;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// These imports are likely not needed for ExteriorBookingpage itself, but good to keep if they are part of the overall navigation.
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Home_Booking_Page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Interior_Booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/pet_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/vehicle_booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/cart/Cartpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/cart/cart_service.dart';
import 'package:swiftclean_project/MVVM/model/models/cart_model.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';

class ExteriorBookingpage extends StatefulWidget {
  String? serviceName;
  String? image;
  String? originalPrice;
  String? discountPrice;
  String? discount;
  int? rating;
  String? category;
  String? serviceType;
  ExteriorBookingpage({
    super.key,
    this.serviceName,
    this.image,
    this.originalPrice,
    this.discountPrice,
    this.discount,
    this.rating,
    this.category,
    this.serviceType,
  });

  @override
  State<ExteriorBookingpage> createState() => _ExteriorBookingpageState();
}

class _ExteriorBookingpageState extends State<ExteriorBookingpage> {
  double _currentSliderValue = 1000;
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;
  double realPrice = 0.0; // This will be updated in initState

  int hour = 8;
  int minute = 30;
  String meridiem = 'AM';

  @override
  void initState() {
    super.initState();
    // Initialize realPrice from discountPrice if available, otherwise from originalPrice
    if (widget.discountPrice != null &&
        double.tryParse(widget.discountPrice!) != null) {
      realPrice = double.parse(widget.discountPrice!);
    } else if (widget.originalPrice != null &&
        double.tryParse(widget.originalPrice!) != null) {
      realPrice = double.parse(widget.originalPrice!);
    }
  }

  List<DateTime> getWeekDates() {
    final today = DateTime.now();
    return List.generate(30, (index) => today.add(Duration(days: index)));
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  void incrementHour() {
    setState(() {
      if (hour == 11) {
        hour = 12;
        meridiem = meridiem == 'AM' ? 'PM' : 'AM';
      } else if (hour == 12) {
        hour = 1;
      } else {
        hour++;
      }
    });
  }

  void decrementHour() {
    setState(() {
      if (hour == 12) {
        hour = 11;
      } else if (hour == 1) {
        hour = 12;
        meridiem = meridiem == 'AM' ? 'PM' : 'AM';
      } else {
        hour--;
      }
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
        minute = 59;
        decrementHour();
      }
    });
  }

  void toggleMeridiem(String value) {
    setState(() {
      meridiem = value;
    });
  }

  String get formattedDate {
    final date = selectedDate;
    return '${DateFormat.E().format(date)}, ${DateFormat.MMMd().format(date)}';
  }

  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $meridiem';
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = getWeekDates();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset("assets/image/garden_size_large.png",
                    width: double.infinity),
                // Bottom Booking Panel
                Container(
                  width: 440,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 249, 249),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Garden Size",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Slider(
                            activeColor: gradientgreen2.c,
                            value: _currentSliderValue,
                            max: 1500,
                            divisions: 30,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select Date",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              TextButton(
                                onPressed: () async {
                                  // Implement a date picker here for "Custom Date"
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(
                                        days: 365)), // One year from now
                                  );
                                  if (pickedDate != null &&
                                      pickedDate != selectedDate) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                      // Find the index of the picked date in weekDates to update selectedIndex
                                      final index = weekDates.indexWhere(
                                          (date) =>
                                              date.year == pickedDate.year &&
                                              date.month == pickedDate.month &&
                                              date.day == pickedDate.day);
                                      if (index != -1) {
                                        selectedIndex = index;
                                      } else {
                                        // If the date is outside the initial 30 days, we just set selectedDate
                                        // and keep selectedIndex as is or handle it as needed.
                                        // For simplicity, we might just update the date without changing selectedIndex.
                                        // A more robust solution might rebuild the weekDates list to include the selected date.
                                      }
                                    });
                                  }
                                },
                                child: Text("Custom Date",
                                    style: TextStyle(
                                        fontSize: 14, color: gradientgreen2.c)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weekDates.length,
                              itemBuilder: (context, index) {
                                final date = weekDates[index];
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
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? gradientgreen2.c
                                          : const Color.fromRGBO(
                                              229, 229, 229, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat.E().format(date),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${date.day}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          monthName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Select Time",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Hour Column
                              Column(
                                children: [
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.add,
                                          color: gradientgreen2.c),
                                      onPressed: incrementHour,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 4)
                                        ],
                                      ),
                                      child: Text(
                                          hour.toString().padLeft(2, '0'),
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.remove,
                                          color: gradientgreen2.c),
                                      onPressed: decrementHour,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Text(":", style: TextStyle(fontSize: 22)),
                              SizedBox(width: 10),
                              // Minute Column
                              Column(
                                children: [
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.add,
                                          color: gradientgreen2.c),
                                      onPressed: incrementMinute,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 4)
                                        ],
                                      ),
                                      child: Text(
                                          minute.toString().padLeft(2, '0'),
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.remove,
                                          color: gradientgreen2.c),
                                      onPressed: decrementMinute,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: meridiem == 'AM'
                                      ? gradientgreen2.c
                                      : const Color.fromARGB(
                                          255, 231, 231, 231),
                                  foregroundColor: meridiem == 'AM'
                                      ? Colors.white
                                      : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: const Size(52, 42),
                                ),
                                onPressed: () => toggleMeridiem('AM'),
                                child: const Text("AM"),
                              ),
                              SizedBox(width: 13),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: meridiem == 'PM'
                                      ? gradientgreen2.c
                                      : const Color.fromARGB(
                                          255, 231, 231, 231),
                                  foregroundColor: meridiem == 'PM'
                                      ? Colors.white
                                      : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: const Size(52, 42),
                                ),
                                onPressed: () => toggleMeridiem('PM'),
                                child: const Text("PM"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Price Footer
              ],
            ),
            Positioned(
              top: 10,
              left: 15,
              child: SafeArea(
                child: customBackbutton1(
                  onpress: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 330,
              left: 320,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart_outlined),
                onPressed: () async {
             
                  // Call the static method from CartService
                  await CartService.addToCart(
                    context: context, // Pass the current context
                    serviceName: widget.serviceName,
                    image: widget.image,
                    originalPrice: widget.originalPrice,
                    discountPrice: widget.discountPrice,
                    discount: widget.discount,
                    rating: widget.rating,
                    category: widget.category,
                    serviceType: widget.serviceType,
                  );
                }, // Call the refactored addToCart function
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Image.asset("assets/icons/dollar.png", scale: 2),
            SizedBox(width: 10),
            Text("$realPrice",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text("/hour",
                style: TextStyle(
                    color: const Color.fromRGBO(133, 130, 130, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Spacer(),
            SizedBox(
              height: 57,
              width: 160,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gradientgreen2.c,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      "Selected: $formattedDate at $formattedTime",
                      style: TextStyle(color: Colors.black),
                    ),
                  ));
                },
                child: Text("Book Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
