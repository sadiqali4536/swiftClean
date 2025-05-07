import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 102, 214, 10),
                  Color.fromARGB(255, 113, 191, 4),
                  Color.fromARGB(255, 26, 159, 6),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  customBackbutton1(
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bottomnvigationbar()),
                      );
                    },
                  ),
                  const SizedBox(width: 80),
                  const Text(
                    "My Bookings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Booking Cards
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 145,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Service Image
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              "assets/image/Gardens.png",
                              height: 110,
                              width: 95,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Info Column
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Garden",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 3),

                                  // Rating
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: 4.8,
                                        itemBuilder: (_, __) => const Icon(
                                          Icons.star,
                                          color: gradientgreen2.c,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        "4.8",
                                        style: TextStyle(
                                          color: gradientgreen2.c,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Price
                                  Row(
                                    children: const [
                                      Icon(Icons.arrow_downward, size: 15, color: gradientgreen2.c),
                                      Text("33%", style: TextStyle(color: gradientgreen2.c)),
                                      SizedBox(width: 5),
                                      Text(
                                        "₹299",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "₹200",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("/Hour",
                                       style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                                      
                                      
                                    ],
                                  ),
                                  Text("(Depends on work)",
                                  style: TextStyle(color: const Color.fromARGB(255, 139, 138, 138)),)
                                ],
                              ),
                            ),
                          ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 80),
                             child: IconButton(
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: SizedBox(
                                      height: 240,
                                      width: 374,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                         Container(
                                          height: 60,
                                          width: 60,
                                          child: Icon(Icons.question_mark,
                                          size: 32,
                                          color: Colors.white,),
                                          decoration: BoxDecoration(
                                          color: const Color.fromRGBO(88,142, 12, 1),     
                                          borderRadius: BorderRadius.circular(30)
                                          ),
                                         ),
                                         SizedBox(height: 10,),
                                          Text("Are you sure you want to",
                                          style: TextStyle(fontSize: 20,
                                                color: Color.fromRGBO(125, 117, 128, 1),
                                                fontWeight: FontWeight.bold),),
                                          Text("cancel this order?",
                                          style: TextStyle(fontSize: 20,
                                                color: Color.fromRGBO(125, 117, 128, 1),
                                                fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 20,),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 140),
                                                      child: Container(
                                                      height: 50,
                                                      width: 145,
                                                      decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(217, 217, 217, 1),
                                                     ),
                                                    child: TextButton(
                                                      onPressed: (){
                                                         Navigator.pop(context);
                                                      }, 
                                                      child: Text("No, Keep Order",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                        fontSize: 15,
                                                      ),)),
                                                    ),
                                                    ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 160),
                                                  child: Container(
                                                    height: 50,
                                                    width: 145,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(199, 3, 3, 1),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: (){}, 
                                                      child: Text("Yes, Cancel Order",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(255, 255, 255, 1),
                                                        fontSize: 15,
                                                      ),)),
                                                  ),
                                                ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                  );
                                  });
                              }, 
                              icon: Image.asset("assets/icons/trash bin.png")),
                           ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
