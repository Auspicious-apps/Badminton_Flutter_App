
class BookingRequestModel {
  static Map<String, dynamic> bookingRequestModel({
    required bool askToJoin,
    required bool isCompetitive,
    required num skillRequired,
    required List<Map<String, dynamic>> team1,
    List<Map<String, dynamic>>? team2, // optional
    required String venueId,
    required String courtId,
    required String bookingDate, // ISO 8601 format (e.g., "2025-05-19T17:00:00.000Z")
    required List<String> bookingSlots,
    required String bookingType, // "Booking" or "Complete"
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["askToJoin"] = askToJoin;
    data["isCompetitive"] = isCompetitive;
    data["skillRequired"] = skillRequired;
    data["team1"] = team1;
    data["team2"] = team2;
    data["venueId"] = venueId;
    data["courtId"] = courtId;
    data["bookingDate"] = bookingDate;
    data["bookingSlots"] = bookingSlots;
    data["bookingType"] = bookingType;

    return data;
  }


  static Map<String, dynamic> uploadScoreRequestModel({
    String? bookingId,
    Map<String, int>? set1,
    Map<String, int>? set2,
    Map<String, int>? set3,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingId != null) data['bookingId'] = bookingId;
    if (set1 != null) data['set1'] = set1;
    if (set2 != null) data['set2'] = set2;
    if (set3 != null) data['set3'] = set3;

    return data;
  }


  static Map<String, dynamic> CancleBooking({
  required  String? bookingId
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookingId != null) data['bookingId'] = bookingId;


    return data;
  }


  static Map<String, dynamic> buyPackage({
      String? amount,
      String? packageId
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amount != null) data['amount'] = amount;
    if (packageId != null) data['packageId'] = packageId;


    return data;
  }


  static Map<String, dynamic> notificationRead({
    required  String? notificationId
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationId != null) data['notificationId'] = notificationId;


    return data;
  }


  static PaymentRequest({
    required String transactionId,
    required String method

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["transactionId"] = transactionId;
    data['method']=method;


    return data;
  }



  static JoinBooking({
    required String bookingId,
    required String requestedPosition ,
    required String requestedTeam,
    required String rackets,
    // required String racketB,
    // required String racketC,
    required String balls,
    required String paymentMethod,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["bookingId"] = bookingId;
    data['requestedPosition']=requestedPosition;
    data['requestedTeam']=requestedTeam;
    data['rackets']=rackets;

    data['balls']=balls;
    data['paymentMethod']=paymentMethod;
    return data;
  }



}