// lib/controllers/rank_controller.dart
import 'package:get/get.dart';

class RankController extends GetxController {
  var selectedIndex = 0.obs;

  final rankings = [
    {
      'name': 'Murphy Brandson',
      'country': 'Indonesia',
      'points': '11258',
      'rank': 1,
    },
    {
      'name': 'Mona Reznick',
      'country': 'England',
      'points': '11021',
      'rank': 2,
    },
    {
      'name': 'John Doe',
      'country': 'USA',
      'points': '10980',
      'rank': 3,
    },
    {
      'name': 'Alice Smith',
      'country': 'Canada',
      'points': '10800',
      'rank': 4,
    },
  ].obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
