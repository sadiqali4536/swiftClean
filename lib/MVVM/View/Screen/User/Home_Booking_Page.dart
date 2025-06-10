import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';

class HomeBookingPage extends StatefulWidget {
  const HomeBookingPage({super.key});

  @override
  State<HomeBookingPage> createState() => _HomeBookingPageState();
}

class _HomeBookingPageState extends State<HomeBookingPage> {
  double _currentSliderValue =1000;
 DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;

   int hour = DateTime.now().hour %12;
  int minute = DateTime.now().minute;
  String meridiem = 'AM';

  /// Get next 30 dates
  List<DateTime> getWeekDates() {
    final today = DateTime.now();
    return List.generate(30, (index) => today.add(Duration(days: index)));
  }

  /// Convert numeric month to name
  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  /// Time controls
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

  /// Format date/time for display
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
               
                Image.asset("assets/image/home_cleaning.png", width: double.infinity),
                // Bottom Booking Panel
                Container(
                  width: 440,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 249, 249),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Home Size",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                              TextButton(
                                onPressed: () {},
                                child: Text("Custom Date",
                                    style: TextStyle(fontSize: 14, color: gradientgreen2.c)),
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
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? gradientgreen2.c
                                          : const Color.fromRGBO(229, 229, 229, 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat.E().format(date),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${date.day}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          monthName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : Colors.black,
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
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                                      icon: Icon(Icons.add, color: gradientgreen2.c),
                                      onPressed: incrementHour,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey.shade300, blurRadius: 4)
                                        ],
                                      ),
                                      child: Text(hour.toString().padLeft(2, '0'),
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.remove, color: gradientgreen2.c),
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
                                      icon: Icon(Icons.add, color: gradientgreen2.c),
                                      onPressed: incrementMinute,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey.shade300, blurRadius: 4)
                                        ],
                                      ),
                                      child: Text(minute.toString().padLeft(2, '0'),
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(30),
                                    child: IconButton(
                                      icon: Icon(Icons.remove, color: gradientgreen2.c),
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
                                      : const Color.fromARGB(255, 231, 231, 231),
                                  foregroundColor:
                                      meridiem == 'AM' ? Colors.white : Colors.black,
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
                                      : const Color.fromARGB(255, 231, 231, 231),
                                  foregroundColor:
                                      meridiem == 'PM' ? Colors.white : Colors.black,
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
                          SizedBox(height: 110,)
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
                       onPressed: (){
      
                       },
                        icon:Icon(Icons.add_shopping_cart_outlined)),
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
                        Text("Price",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Text("/Day",
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
