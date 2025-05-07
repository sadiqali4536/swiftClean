Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Loginandsigning()),(route) => false,);  // removes all screens before 
call
Padding(
            padding: const EdgeInsets.only(top: 440,left: 12),
            child: SizedBox(
              height: 39,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  bool isSelected =selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex =index;
                        });
                      },
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 95,
                          height: 50,
                          padding: EdgeInsets.all(Tsize.sm),
                          decoration: BoxDecoration(
                            color: isSelected ? gradientgreen2.c : primary.c,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? gradientgreen2.c : Color.fromRGBO(95, 94,94, 1),
                              width: 1,
                            )
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(fontSize: 12,
                              color: isSelected ? primary.c : black.c,
                                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

///////////////////////////////////////////////


         import 'package:flutter/material.dart';
import 'package:swift_clean/MVVM/utils/widget/card/ServiceCard.dart';

class ServiceGrid extends StatelessWidget {
  final List<String> serviceNames = [
    "Full Home Cleaning",
    "Regular Cleaning",
    "Deep Cleaning",
    "Car Washing",
    "Pet Cleaning",
    "Grass Cutting"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: serviceNames.length, // Correct count
          shrinkWrap: true, // Ensures it takes only required space
          physics: const NeverScrollableScrollPhysics(), // Prevents internal scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 160, // Controls height
          ),
          itemBuilder: (context, index) {
            return ServiceCardVertical(serviceName: serviceNames[index]);
          },
        ),
      ),
    );
  }
}
/////////////////////////////////////////////
worker payment dash board

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WorkerShiftTimePage(),
  ));
}

class WorkerShiftTimePage extends StatefulWidget {
  @override
  _WorkerShiftTimePageState createState() => _WorkerShiftTimePageState();
}

class _WorkerShiftTimePageState extends State<WorkerShiftTimePage> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String selectedWorkType = 'Home Cleaning';

  final Map<String, int> workTypes = {
    'Home Cleaning': 200,
    'Car Washing': 150,
    'Pet Cleaning': 180,
    'Grass Cutting': 170,
  };

  String formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return "--:--";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  Duration getWorkingDuration() {
    if (startTime == null || endTime == null) return Duration.zero;
    final start = DateTime(0, 0, 0, startTime!.hour, startTime!.minute);
    final end = DateTime(0, 0, 0, endTime!.hour, endTime!.minute);
    return end.isAfter(start) ? end.difference(start) : Duration.zero;
  }

  void pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        isStart ? startTime = picked : endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = getWorkingDuration();
    final hourlyRate = workTypes[selectedWorkType]!;
    final totalPrice = (duration.inMinutes / 60.0) * hourlyRate;

    return Scaffold(
      appBar: AppBar(
        title: Text("Worker Shift Timings"),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Work Type", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedWorkType,
              isExpanded: true,
              items: workTypes.keys.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedWorkType = value;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text("Start Time", style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              title: Text(formatTimeOfDay(startTime)),
              trailing: Icon(Icons.access_time),
              onTap: () => pickTime(true),
            ),
            Text("End Time", style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              title: Text(formatTimeOfDay(endTime)),
              trailing: Icon(Icons.access_time),
              onTap: () => pickTime(false),
            ),
            SizedBox(height: 20),
            Text(
              "Duration: ${duration.inHours} hrs ${duration.inMinutes % 60} mins",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Hourly Rate: ₹$hourlyRate/hour",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Total Price: ₹${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Spacer(),
            ElevatedButton.icon(
              icon: Icon(Icons.payment),
              label: Text("Proceed to Payment"),
              onPressed: () {
                if (startTime == null || endTime == null || duration == Duration.zero) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select valid shift timings")),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      price: totalPrice,
                      workType: selectedWorkType,
                      duration: duration,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final double price;
  final String workType;
  final Duration duration;

  const PaymentScreen({
    Key? key,
    required this.price,
    required this.workType,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Gateway"),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service: $workType", style: TextStyle(fontSize: 18)),
            Text("Duration: ${duration.inHours} hrs ${duration.inMinutes % 60} mins", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Total Amount", style: TextStyle(fontSize: 20)),
            Text("₹${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
            Spacer(),
            ElevatedButton.icon(
              icon: Icon(Icons.payment),
              label: Text("Pay Now"),
              onPressed: () {
                // TODO: Integrate real payment gateway
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Payment Successful (Mocked)")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////
auto pyment calculation
import 'package:flutter/material.dart';

class PetCleaning extends StatefulWidget {
  const PetCleaning({super.key});

  @override
  State<PetCleaning> createState() => _PetCleaningState();
}

class _PetCleaningState extends State<PetCleaning> {
  int count = 1;
  int selectedDateIndex = 0;
  int selectedHour = 1;
  bool isAm = true;
  int pricePerRoom = 200;

  List<String> dates = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> services = ['Bathing', 'Haircut', 'Grooming', 'Vet Visit'];
  String selectedService = 'Bathing';

  int get totalPrice => count * pricePerRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Cleaning"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Select Service',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final isSelected = service == selectedService;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(service),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedService = service;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == selectedDateIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              dates[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Select Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (selectedHour > 1) selectedHour--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '$selectedHour:00 ${isAm ? 'AM' : 'PM'}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (selectedHour < 12) selectedHour++;
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    Switch(
                      value: isAm,
                      onChanged: (value) {
                        setState(() {
                          isAm = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Number of Rooms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (count > 1) count--;
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      count.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 100), // Extra space for bottom bar
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹$totalPrice",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "/Day",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // You can add booking logic here
                    },
                    child: const Text("Book Now"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
