import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';

class InteriorBookingPage extends StatefulWidget {
  const InteriorBookingPage({super.key});

  @override
  State<InteriorBookingPage> createState() => _InteriorBookingPageState();
}

class _InteriorBookingPageState extends State<InteriorBookingPage> {
   DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;

  int hour = 8;
  int minute = 30;
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
      minute += 1;
      if (minute >= 60) {
        minute = 0;
        incrementHour();
      }
    });
  }

  void decrementMinute() {
    setState(() {
      minute -= 1;
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

  String selectedRoom = 'Living Room'; // new state variable

// Update room selection
void selectRoom(String room) {
  setState(() {
    selectedRoom = room;
  });
}

  int count = 1;

  void incrementCount(){
    setState(() {
      count++;
    });
  }

  void decrementCount(){
    setState(() {
      if(count > 0) count--;
    });
  }
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Start date
      lastDate: DateTime(2100), // End date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/image/interior_room.png"),
          Padding(
            padding: const EdgeInsets.only(top: 28,left: 10),
            child: customBackbutton1(
              onpress: (){
              Navigator.pop(context);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270),
            child: Container(
              height: 695,
              width: 440,
                   decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 250, 249, 249)
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40,left: 20),
                    child: Text("Select Room",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                        
   SingleChildScrollView(
    scrollDirection: Axis.horizontal,
     child: Row(
       children: [
        Padding(
      padding: const EdgeInsets.only(top: 80,left: 18),
      child: TextButton(
        style: TextButton.styleFrom(
      backgroundColor: meridiem == "Living Room"
          ? gradientgreen2.c
          : const Color.fromARGB(255, 231, 231, 231),
      foregroundColor: meridiem == "Living Room" ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(76, 40),
        ),
        onPressed: () => toggleMeridiem("Living Room"),
        child: Text(
      "Living Room",
      style: TextStyle(
        color: meridiem == "Living Room" ? Colors.white : Colors.black,
      ),
        ),
      ),
    ),
     Padding(
     padding: const EdgeInsets.only(top: 80,left: 10),
     child: TextButton(
    style: TextButton.styleFrom(
      backgroundColor: meridiem == "Bedroom"
          ? gradientgreen2.c
          : const Color.fromARGB(255, 231, 231, 231),
      foregroundColor: meridiem == "Bedroom" ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(76, 40),
    ),
    onPressed: () => toggleMeridiem("Bedroom"),
    child: Text(
      "Bedroom",
      style: TextStyle(
        color: meridiem == "Bedroom" ? Colors.white : Colors.black,
      ),
    ),
     ),
   ),
    Padding(
     padding: const EdgeInsets.only(top: 80,left: 10),
     child: TextButton(
       style: TextButton.styleFrom(
      backgroundColor: meridiem == "Dining Room"
          ? gradientgreen2.c
          : const Color.fromARGB(255, 231, 231, 231),
      foregroundColor: meridiem == "Dining Room" ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(76, 40),
       ),
       onPressed: () => toggleMeridiem("Dining Room"),
       child: Text(
      "Dining Room",
      style: TextStyle(
        color: meridiem == "Dining Room" ? Colors.white : Colors.black,
      ),
       ),
     ),
   ),
         Padding(
           padding: const EdgeInsets.only(top: 80,left: 10),
           child: TextButton(
             style: TextButton.styleFrom(
            backgroundColor: meridiem == "Bathroom"? gradientgreen2.c: const Color.fromARGB(255, 231, 231, 231),
            foregroundColor: meridiem == "Bathroom" ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(76, 40),
             ),
             onPressed: () => toggleMeridiem("Bathroom"),
             child: Text(
            "Bathroom",
            style: TextStyle(
              color: meridiem == "Bathroom" ? Colors.white : Colors.black,
            ),
             ),
           ),
         ),
     Padding(
     padding: const EdgeInsets.only(top: 80,left: 10),
     child: TextButton(
       style: TextButton.styleFrom(
      backgroundColor: meridiem == "Laundry Room"
          ? gradientgreen2.c
          : const Color.fromARGB(255, 231, 231, 231),
      foregroundColor: meridiem == "Laundry Room" ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(76, 40),
       ),
       onPressed: () => toggleMeridiem("Laundry Room"),
       child: Text(
      "Laundry Room",
      style: TextStyle(
        color: meridiem == "Laundry Room" ? Colors.white : Colors.black,
      ),
       ),
     ),
   ),
     Padding(
     padding: const EdgeInsets.only(top: 80,left: 10),
     child: TextButton(
       style: TextButton.styleFrom(
      backgroundColor: meridiem == "Study Room"
          ? gradientgreen2.c
          : const Color.fromARGB(255, 231, 231, 231),
      foregroundColor: meridiem == "Study Room" ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(76, 40),
       ),
       onPressed: () => toggleMeridiem("Study Room"),
       child: Text(
      "Study Room",
      style: TextStyle(
        color: meridiem == "Study Room" ? Colors.white : Colors.black,
      ),
       ),
     ),
   ),
   SizedBox(width: 5,)
       ],
     ),
   ),
       Padding(
        padding: const EdgeInsets.only(top: 120,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Date Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2,top: 20),
                  child: Text(
                    "Select Date",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 10,),
        
            /// --- Date Selector ---
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
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
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? gradientgreen2.c : const Color.fromRGBO(229, 229, 229, 1),
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
                            '${date.day} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                           SizedBox(height: 5),
                           Text(
                            '${monthName} ',
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
            SizedBox(height: 10,),
            Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Select Time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour
                  Column(
                    children: [
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon: Icon(Icons.add),
                       color: gradientgreen2.c,
                         onPressed: incrementHour),
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
                            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
                          ),
                          child: Text(hour.toString().padLeft(2, '0'), style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon:Icon(Icons.remove,
                          color: gradientgreen2.c,), 
                          onPressed: decrementHour),
                      ),
                    ],
                  ),
                      
                  SizedBox(width: 10),
                  Text(":", style: TextStyle(fontSize: 22)),
                  SizedBox(width: 10),
                      
                  // Minute
                  Column(
                    children: [
                      Material(elevation: 6,
                      borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon: Icon(Icons.add,color: gradientgreen2.c,),
                           onPressed: incrementMinute)),
                           SizedBox(height: 15,),
                      Material(
                        elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
                          ),
                          child: Text(minute.toString().padLeft(2, '0'), style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Material(
                        elevation: 6,
                      borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon: Icon(Icons.remove,color: gradientgreen2.c,),
                           onPressed: decrementMinute)),
                    ],
                  ),  
                                      
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextButton(
                     style: TextButton.styleFrom(
                     backgroundColor: meridiem == 'AM' ? gradientgreen2.c : const Color.fromARGB(255, 231, 231, 231),
                     foregroundColor: meridiem == 'AM' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                     ),
                      minimumSize: const Size(52, 42),
                    ),
                     onPressed: () => toggleMeridiem('AM'),
                    child: const Text("AM"),
                                         ),
                  ),
                  const SizedBox(width: 13), 
                  TextButton(
                  style: TextButton.styleFrom(
                  backgroundColor: meridiem == 'PM' ? gradientgreen2.c : const Color.fromARGB(255, 231, 231, 231),
                  foregroundColor: meridiem == 'PM' ? Colors.white : Colors.black,
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
            ),
            
               ],
                ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 320,top: 300),
                   child: Text("Rooms",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                   ),),
                 ),
          // count
              Padding(
              padding: const EdgeInsets.only(left: 300,top: 330),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Material(elevation: 6,
                      borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon: Icon(Icons.add,color: gradientgreen2.c,),
                           onPressed: incrementCount)),
                           SizedBox(height: 15,),
                      Material(
                        elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
                          ),
                          child: Text(count.toString().padLeft(2, '0'), style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Material(
                        elevation: 6,
                      borderRadius: BorderRadius.circular(30),
                        child: IconButton(
                          icon: Icon(Icons.remove,color: gradientgreen2.c,),
                           onPressed: decrementCount)),
                           ]),
                    ],
                  ), 
               )]
                    ),
            )
          ),
          Padding(
             padding: const EdgeInsets.only(top: 780,right: 0),
             child: Container(
              height: 100,
              width: 420,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 16),
                    child: Image.asset("assets/icons/dollar.png",scale: 2,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Price",style: TextStyle(
                      color: Colors.white,fontSize: 30,
                    fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.only(top: 26,left:3 ),
                    child: Text("/Day",style: TextStyle(
                      color: const Color.fromRGBO(133, 130, 130, 1),
                      fontSize: 20,
                    fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20)),
                color: Colors.black
              ),
               ),
              ), 
            // --- Confirm Button ---
            Padding(
              padding: const EdgeInsets.only(top: 800,left: 190),
              child: SizedBox(
                height: 57,
                width: 204,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: gradientgreen2.c),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.white,
                    content: Text("Booked: $formattedDate at $formattedTime",
                    style: TextStyle(color: Colors.black),),
                  ));
                },
                child: Text("Book Now",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white
                ),),
                           ),
              ),
            ),
        ],
      ),
    );
  }
}