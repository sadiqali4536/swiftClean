import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/cartservicecard.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/servicecard2.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 102, 214, 10),
                    Color.fromARGB(255, 113, 191, 4),
                    Color.fromARGB(255, 26, 159, 6),
                  ],
                ),
              ),
              padding: const EdgeInsets.only(top: 30),
              child: const Center(
                child: Text(
                  "My Cart",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
                Cartservicecard(),
                if(isExpanded)...[
                  SizedBox(height: 200,),
                ]
                
            
          ],
        ),
      ),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:!isExpanded ? const EdgeInsets.only(bottom:  100.0,right: 10):EdgeInsets.all(0),
            child: FloatingActionButton.small(onPressed: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },child: Icon(isExpanded ? Icons.arrow_downward : Icons.arrow_upward),),
          ),
          if(isExpanded)...[
            Padding(
            padding: const EdgeInsets.only(bottom:  50.0),
            child: Container(
                    height: screenHeight * 0.27,
                    width: screenWidth * 0.96,
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price Details",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Price (2 Bookings)",
                              style: TextStyle(fontSize: 15, color: Color.fromRGBO(87, 86, 86, 1)),
                            ),
                            Text(
                              "₹1,799",
                              style: TextStyle(fontSize: 15, color: Color.fromRGBO(87, 86, 86, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Discount",
                              style: TextStyle(fontSize: 15, color: Color.fromRGBO(87, 86, 86, 1)),
                            ),
                            Text(
                              "-₹399",
                              style: TextStyle(fontSize: 15, color: Color.fromRGBO(53, 120, 1, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
            
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Amount",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "₹1,799",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color.fromRGBO(163, 161, 161, 1),
                                  ),
                                ),
                                Text(
                                  "₹1,400",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
            
                        // Book Now Button
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 150,
                            child: Custombutton(
                              text: const Text(
                                "Book Now",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              onpress: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          ]
        ],
      ),
    );
  }
}
