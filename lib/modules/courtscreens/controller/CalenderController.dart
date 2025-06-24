import 'package:get/get.dart';

class CalendarController extends GetxController {
  final Rx<DateTime> startDate = DateTime.now().obs;
  final Rx<DateTime> controllerSelectedDate = DateTime.now().obs; // Current date by default

  void updateSelectedDate(DateTime date) {
    controllerSelectedDate.value = date;
  }

  void shiftStartDate() {
    startDate.value = startDate.value.add(const Duration(days: 1));
  }
}