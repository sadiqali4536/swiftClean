import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/image_strings.dart';

class ServiceCard extends StatefulWidget {
  String title;
  double rating;
  String image;
   ServiceCard({super.key,required this.image,required this.rating,required this.title,});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  



  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey[400]!,blurRadius: 1.6)
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: Center(
                            child: Image.asset(
                              widget.image,
                              height: 125, 
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 100,
                               
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
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
                              Text(widget.rating.toString(),
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
                      padding: const EdgeInsets.only(top: 8,left: 8),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                        widget.title,
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}


