import 'court_detail_model.dart';

class CourtSelection {
  String? rate;
  List<AvailableSlots> timeSlots;
  String? game;

  CourtSelection({this.rate, List<AvailableSlots>? timeSlots, this.game})
      : timeSlots = timeSlots != null ? List<AvailableSlots>.from(timeSlots) : [];
}
