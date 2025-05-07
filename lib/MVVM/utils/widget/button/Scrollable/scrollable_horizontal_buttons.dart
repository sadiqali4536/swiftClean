import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

class ScrollableHorizontalButtons extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<int>? onSelected;

  const ScrollableHorizontalButtons({
    super.key, 
    required this.categories, 
    this.onSelected});

  @override
  State<ScrollableHorizontalButtons> createState() => _ScrollableHorizontalButtonsState();
}

class _ScrollableHorizontalButtonsState extends State<ScrollableHorizontalButtons> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index){
          bool isSelected =selectedIndex == index;
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex =index;
              });
              if (widget.onSelected !=null){
                widget.onSelected!(index);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? gradientgreen2.c : const Color.fromRGBO(189, 189, 189, 1)),
                gradient: isSelected ? const LinearGradient(
                  colors: [
                          gradientgreen1.c,
                          gradientgreen2.c,
                          gradientgreen3.c],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight
                          ):null,
                          color: isSelected ? null : Colors.white,
                          boxShadow: [
                           if (isSelected)
                           BoxShadow(
                            color: gradientgreen2.c.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3)
                            ),
                          ],
                         ),
                           child: Center(
                            child: Text(widget.categories[index],
                            style: TextStyle(
                             fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : black.c,
                            ),),
                          ),
                        ),
                      );
                     }
                    ),
                  );
                 }
                }