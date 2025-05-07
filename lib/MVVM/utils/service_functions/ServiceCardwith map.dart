import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/image_strings.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  final List<Map<String, dynamic>> cardMap = [
    {
      "title": "Gardens",
      "images": AppImages.grassCutImg,
      
    },
    {
      "title": "Living Rooms",
      "images": AppImages.Rooms,
       
    },
    {
      "title": "Deep Cleaning",
      "images": AppImages.deepCleaning,
       
    },
    {
      "title": "Exterior Wash",
      "images": AppImages.exteriorWash,
       
    },
    {
      "title": "Pet Cleaning",
      "images": AppImages.petCleaning,
      
    },
    {
      "title": "OutdoorFurniture",
      "images": AppImages.outdoorCleaning,
      
    },
  ];


  void onCardClick(int index){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Clicked on ${cardMap[index]['title']}"),
      duration: const Duration(seconds: 1),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 160,
          childAspectRatio: 0.8,
        ),
        itemCount: cardMap.length,
        itemBuilder: (_, index) {
          return GestureDetector(
              onTap: () => onCardClick(index),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.black.withOpacity(0.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Image.asset(
                            cardMap[index]['images'],
                            height: 125, 
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 100,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top:97,left: 8),
                        child: Container(
                          height: 20,
                          width: 45,
                          decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                            color: primary.c
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("4.3",
                                 style:TextStyle(fontWeight: FontWeight.bold,),),
                              SizedBox(width: 2,),
                              Icon(Icons.star,
                                  size: 14,
                                  color: gradientgreen2.c,)
                            ],
                          ),
                        ),
                      )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cardMap[index]['title'],
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
