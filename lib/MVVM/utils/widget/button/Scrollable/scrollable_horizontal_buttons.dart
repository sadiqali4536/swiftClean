// import 'package:flutter/material.dart';
// import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

// class ScrollableHorizontalButtons extends StatelessWidget {
//   final List<String> categories;
//   final int selectedIndex;
//   final ValueChanged<int>? onSelected;

//   const ScrollableHorizontalButtons({
//     super.key,
//     required this.categories,
//     required this.selectedIndex,
//     this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 39,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           bool isSelected = selectedIndex == index;

//           return GestureDetector(
//             onTap: () {
//               if (onSelected != null) {
//                 onSelected!(index);
//               }
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 2),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: isSelected ? gradientgreen2.c : const Color.fromRGBO(189, 189, 189, 1),
//                 ),
//                 gradient: isSelected
//                     ? const LinearGradient(
//                         colors: [gradientgreen1.c, gradientgreen2.c, gradientgreen3.c],
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight,
//                       )
//                     : null,
//                 color: isSelected ? null : Colors.white,
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: gradientgreen2.c.withOpacity(0.4),
//                           blurRadius: 1.5,
//                         ),
//                       ]
//                     : [],
//               ),
//               child: Center(
//                 child: Text(
//                   categories[index],
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: isSelected ? Colors.white : black.c,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

class ScrollableHorizontalButtons extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  const ScrollableHorizontalButtons({
    super.key,
    required this.categories,
    required this.selectedIndex,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onSelected?.call(index),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? gradientgreen2.c
                        : const Color.fromRGBO(189, 189, 189, 1),
                  ),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [gradientgreen1.c, gradientgreen2.c, gradientgreen3.c],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: gradientgreen2.c.withOpacity(0.4),
                            blurRadius: 1.5,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : black.c,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
