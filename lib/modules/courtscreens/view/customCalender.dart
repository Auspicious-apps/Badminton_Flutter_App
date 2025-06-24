import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomLinearCalendar extends StatelessWidget {
  final double itemWidth;
  final double height;
  final Color selectedBorderColor;
  final Color selectedColor;
  final double borderWidth;
  final bool monthVisibility;
  final Function(DateTime) onChanged;
  final Rx<DateTime> startDate; // Change to Rx<DateTime> for reactivity
  final TextStyle unselectedTextStyle;
  final TextStyle selectedTextStyle;
  final Rx<DateTime> controllerSelectedDate;

  const CustomLinearCalendar({
    Key? key,
    required this.itemWidth,
    required this.height,
    required this.selectedBorderColor,
    required this.selectedColor,
    required this.borderWidth,
    required this.monthVisibility,
    required this.onChanged,
    required this.startDate,
    required this.unselectedTextStyle,
    required this.selectedTextStyle,
    required this.controllerSelectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Obx(
            () {
          // Generate list of 5 dates starting from startDate
          List<DateTime> dates = List.generate(
            6,
                (index) => startDate.value.add(Duration(days: index)),
          );

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = controllerSelectedDate.value.day == date.day &&
                  controllerSelectedDate.value.month == date.month &&
                  controllerSelectedDate.value.year == date.year;

              return GestureDetector(
                onTap: () {
                  controllerSelectedDate.value = date;
                  // If the last date is selected, shift startDate to the next day
                  if (date == dates.last) {
                    startDate.value = startDate.value.add(Duration(days: 1));
                  }
                  onChanged(date);
                  print("Selected Date: $date, Start Date: ${startDate.value}");
                },
                child: Container(
                  width: itemWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  // decoration: BoxDecoration(
                  //   color: isSelected ? selectedColor : Colors.transparent,
                  //   border: Border.all(
                  //     color: isSelected ? selectedBorderColor : Colors.grey,
                  //     width: isSelected ? borderWidth : 1,
                  //   ),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // if (monthVisibility)
                      //   Text(
                      //     DateFormat('MMM').format(date),
                      //     style: isSelected
                      //         ? selectedTextStyle
                      //         : unselectedTextStyle,
                      //   ),
                      Label(
                        maxLines:1,
                        txt:DateFormat('EEE').format(date),
                        type: TextTypes.f_14_600,
                        forceColor: isSelected?AppColors.primaryColor:AppColors.grey,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration( color: isSelected?AppColors.primaryColor:Colors.white,borderRadius: BorderRadius.circular(4)),
                       
                        child: Center(
                          child: Label(
                            maxLines:1,
                            txt:DateFormat('dd').format(date),
                            type: TextTypes.f_14_600,
                            forceColor: isSelected?AppColors.whiteColor:AppColors.grey,
                          ),
                        ),
                      ).marginSymmetric(vertical: 10),



                      // Text(
                      //   DateFormat('dd').format(date),
                      //   style: isSelected
                      //       ? selectedTextStyle
                      //       : unselectedTextStyle,
                      // ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}