import 'dart:async';
import 'dart:io';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/modules/auth_module/models/user_response_model.dart';
import 'package:badminton/repository/endpoint.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../app_settings/components/common_textfield.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../repository/api_repository.dart';
import '../../profile/models/Get_friend_request_model.dart';
import '../models/court_detail_model.dart';
import '../models/court_selection model.dart';

class PgCourtdetailController extends GetxController {
var selectedButton = 1.obs;
var selectedButton2 = 0.obs;
RxBool selectedGame = true.obs;
Timer? debounce;
final searchQuery = ''.obs;
var selectedgame = "Padel".obs;
var progressValue = 10.0.obs;
var checkBox = false.obs;
var askJoin = true.obs;
final tooltipcontroller = SuperTooltipController();
final matchtooltipcontroller = SuperTooltipController();
final skilltooltipcontroller = SuperTooltipController();
final searchfriend  = TextEditingController();
RxBool loading = true.obs;
var currentDate = "".obs;
var venueId = "".obs;
var distance = "".obs;
var updatedSlots = <AvailableSlots>[].obs;
Rx<GetCourtDetailResponseModel> userdata = GetCourtDetailResponseModel().obs;
CarouselSliderController carouselController = CarouselSliderController();
var selectedDate = DateTime.now().obs;
var startDate = DateTime.now().obs;
final APIRepository _apiRepository = Get.find<APIRepository>();
var courtSelections = <String, CourtSelection>{}.obs;
var selectedCourtId = ''.obs;
var Rate = "60 Mins".obs;
var HourlyRate = "0".obs;
var selectedFriends = List<Friends?>.filled(4, null).obs;
Rx<GetRequestsResponseModel> friendsdata = GetRequestsResponseModel().obs;
Rx<userResponseModel> userresponseModel = userResponseModel().obs;
Friends? currentUser; // Store current user data

@override
void onInit() {
  final now = DateTime.now();
  currentDate.value = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  WidgetsBinding.instance.addPostFrameCallback((_) {
    onCalendarDateChanged(selectedDate.value);
  });
  // Fetch current user and friends
  fetchCurrentUserAndFriends();

  super.onInit();
  if (Get.arguments != null) {
    venueId.value = Get.arguments["id"];
    distance.value = Get.arguments["distance"]?.toStringAsFixed(2) ?? "0.0";
    getCourtDetail();
  }
}


// Fetch current user and friend requests
Future<void> fetchCurrentUserAndFriends() async {
  try {
    // Fetch current user
    final userResponse = await _apiRepository.getuser();
    if (userResponse != null) {
      userresponseModel.value=userResponse;
      // Assuming userResponse has sId and fullName; adjust based on actual API response
      currentUser = Friends(
        sId:userresponseModel.value.data?.sId ?? '',
        fullName:userresponseModel.value.data?.firstName?? 'You',
        // Map other fields as needed
      );
      // Set current user at index 0
      selectedFriends[0] = currentUser;
      selectedFriends.refresh();
    }
    // Fetch friend requests
    await getFriendRequest();
  } catch (e) {
    Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
  }
}

Future<void> getFriendRequest() async {
  Get.closeAllSnackbars();
  try {
    final response = await _apiRepository.getRequest({"status": "friends-requests","search":searchQuery.value?.trim()});
    if (response != null) {
      friendsdata.value = response;
    }
  } catch (e) {
    Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
  }
}





void onCalendarDateChanged(DateTime value) async {
  selectedDate.value = value;
  final now = value;
  currentDate.value = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  debugPrint("*****************${DateFormat('yyyy-MM-dd').format(value)}***************************");
  try {
    final response = await _apiRepository.getCourtDetail({
      "game": selectedgame?.value ?? "Padel",
      "venueId": venueId?.value,
      "date": currentDate.value
    });
    if (response != null) {
      userdata.value = response;
      if (userdata.value?.data?.courts?.isNotEmpty ?? false) {
        final firstCourt = userdata.value!.data!.courts![0];
        selectedCourtId.value = firstCourt.sId ?? '';
        updateCourtSelection(firstCourt.sId ?? '', game: firstCourt.games ?? 'Padel');
      }
    }
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
  } finally {
    loading.value = false;
  }
}

  Future<void> pickFutureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      startDate.value = picked; // Update startDate to picked date
      courtSelections.value = {};
      updatedSlots.clear();
      selectedCourtId.value = '';
      onCalendarDateChanged(picked);
    }
  }


Future<void> openMap(double? latitude, double? longitude) async {
  print('Attempting to open map for coordinates: $latitude,$longitude');
  final mapUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';
  try {
    if (await canLaunchUrlString(mapUrl)) {
      print('Launching map with URL: $mapUrl');
      await launchUrlString(mapUrl, mode: LaunchMode.externalApplication);
    } else {
      print('Cannot launch map URL: $mapUrl');
      Get.snackbar('Error', 'Could not open map', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
    }
  } catch (e) {
    print('Error launching map: $e');
    Get.snackbar('Error', 'Could not open map: $e', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
    try {
      String fallbackUrl;
      if (Platform.isAndroid) {
        fallbackUrl = 'geo:$latitude,$longitude?z=15&q=$latitude,$longitude';
      } else if (Platform.isIOS) {
        fallbackUrl = 'https://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d';
      } else {
        fallbackUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving';
      }
      if (await canLaunchUrlString(fallbackUrl)) {
        print('Fallback: Launching map with URL: $fallbackUrl');
        await launchUrlString(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        print('Fallback failed: Cannot launch URL: $fallbackUrl');
        Get.snackbar('Error', 'Could not open map (fallback)', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
      }
    } catch (e) {
      print('Error launching fallback map: $e');
      Get.snackbar('Error', 'Could not open map (fallback): $e', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
    }
  }
}

void clearCourtSelection(String courtId) {
  courtSelections.remove(courtId);
  courtSelections.refresh();
}

Future<void> makePhoneCall(String phoneNumber) async {
  final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]+'), '');
  print('Attempting to call: $cleanedNumber');
  if (!RegExp(r'^\+?\d{10,15}$').hasMatch(cleanedNumber)) {
    print('Invalid phone number format: $cleanedNumber');
    Get.snackbar('Error', 'Invalid phone number format', snackPosition: SnackPosition.TOP);
    return;
  }
  final phoneUrl = 'tel:$cleanedNumber';
  try {
    if (await canLaunchUrlString(phoneUrl)) {
      print('Launching dial pad with URL: $phoneUrl');
      await launchUrlString(phoneUrl);
    } else {
      print('Cannot launch URL: $phoneUrl');
      Get.snackbar('Error', 'Could not launch dial pad', snackPosition: SnackPosition.TOP);
    }
  } catch (e) {
    print('Error launching dial pad: $e');
    Get.snackbar('Error', 'Could not launch dial pad: $e', snackPosition: SnackPosition.TOP);
    final phoneUri = Uri(scheme: 'tel', path: cleanedNumber);
    if (await canLaunchUrl(phoneUri)) {
      print('Fallback: Launching dial pad with Uri: $phoneUri');
      await launchUrl(phoneUri);
    } else {
      print('Fallback failed: Cannot launch Uri: $phoneUri');
      Get.snackbar('Error', 'Could not launch dial pad (fallback)', snackPosition: SnackPosition.TOP);
    }
  }
}

IconData getFacilityIcon(String facilityName) {
  switch (facilityName.toLowerCase()) {
    case 'free parking':
    case 'paid parking':
      return Icons.local_parking;
    case 'locker rooms & changing area':
      return Icons.lock;
    case 'rental equipments':
      return Icons.sports_tennis;
    case 'restrooms & showers':
      return Icons.bathtub;
    default:
      return Icons.info;
  }
}

String formatTimeRange(List<String>? hours) {
  if (hours == null || hours.length != 2) return 'N/A';
  try {
    final formatter = DateFormat('h:mm a');
    DateTime parseTime(String time) {
      return DateFormat('HH:mm').parse(time);
    }
    final startTime = parseTime(hours[0]);
    final endTime = parseTime(hours[1]);
    return '${formatter.format(startTime)} - ${formatter.format(endTime)}';
  } catch (e) {
    return 'N/A';
  }
}

  void updateCourtSelection(String courtId, {String? rate, AvailableSlots? timeSlot, String? game}) {
    // Get current selection or create new one
    var selection = courtSelections[courtId] ?? CourtSelection();

    // Create modifiable copies of lists to avoid unmodifiable list errors
    List<AvailableSlots> timeSlotsCopy = List<AvailableSlots>.from(selection.timeSlots);

    // Update rate if provided
    if (rate != null) {
      selection.rate = rate;
      Rate.value = rate;

      // Clear time slots if rate is changed
      if (timeSlotsCopy.isNotEmpty) {
        timeSlotsCopy.clear();
        updatedSlots.clear();
      }
    }

    // Handle time slot selection
    if (timeSlot != null) {
      // Check if slot is already selected
      bool isSelected = timeSlotsCopy.any((slot) => slot.time == timeSlot.time);

      if (isSelected) {
        // Remove slot if already selected
        timeSlotsCopy.removeWhere((slot) => slot.time == timeSlot.time);
        updatedSlots.removeWhere((slot) => slot.time == timeSlot.time);

        // Auto-toggle rate based on number of slots
        if (timeSlotsCopy.isEmpty) {
          // Default to 60 Mins if no slots selected
          selection.rate = "60 Mins";
          Rate.value = "60 Mins";
        } else if (timeSlotsCopy.length == 1) {
          // Set to 60 Mins if only 1 slot selected
          selection.rate = "60 Mins";
          Rate.value = "60 Mins";
        }
      } else {
        // Check slot limits based on rate
        String currentRate = selection.rate ?? "60 Mins";

        // if (currentRate == "60 Mins" && timeSlotsCopy.length >= 1) {
        //   // For 60 mins, only allow 1 slot
        //   Get.closeAllSnackbars();
        //   Get.snackbar(
        //     'Limit Reached',
        //     'You can select only 1 time slot for 60 Mins.',
        //     snackPosition: SnackPosition.TOP,
        //     backgroundColor: Colors.redAccent,
        //     colorText: Colors.white,
        //   );
        // } else
        if (currentRate == "120 Mins" && timeSlotsCopy.length >= 2) {
          // For 120 mins, only allow 2 slots
          Get.closeAllSnackbars();
          Get.snackbar(
            'Limit Reached',
            'You can select up to 2 time slots for 120 Mins.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        } else {
          // Add the slot if within limits
          timeSlotsCopy.add(timeSlot);
          updatedSlots.add(timeSlot);

          // Sort slots by time
          timeSlotsCopy.sort((a, b) {
            if (a.time == null || b.time == null) return 0;
            return a.time!.compareTo(b.time!);
          });

          updatedSlots.sort((a, b) {
            if (a.time == null || b.time == null) return 0;
            return a.time!.compareTo(b.time!);
          });

          // Auto-toggle rate based on number of slots
          if (timeSlotsCopy.length == 1) {
            selection.rate = "60 Mins";
            Rate.value = "60 Mins";
          } else if (timeSlotsCopy.length == 2) {
            selection.rate = "120 Mins";
            Rate.value = "120 Mins";
          }
        }
      }
    }

    // Update game if provided
    if (game != null) {
      selection.game = game;
    }

    // Create a new CourtSelection with the updated timeSlots
    selection = CourtSelection(
      rate: selection.rate,
      timeSlots: timeSlotsCopy,
      game: selection.game,
    );

    // Update the court selection
    courtSelections[courtId] = selection;
    selectedCourtId.value = courtId;

    // Calculate hourly rate
    if (courtId.isNotEmpty) {
      Courts? court;
      try {
        // Find the court safely
        if (userdata.value.data?.courts != null) {
          for (var c in userdata.value.data!.courts!) {
            if (c.sId == courtId) {
              court = c;
              break;
            }
          }
        }
      } catch (e) {
        print("Error finding court: $e");
      }

      // if (court != null) {
      //   final hourlyRate = court.hourlyRate ?? 1200; // Default to 1200 if not available
      //   String currentRate = selection.rate ?? "60 Mins";
      //
      //   HourlyRate.value = (currentRate == "60 Mins")
      //       ? hourlyRate.toString()
      //       : (hourlyRate * 2).toString();
      // }
    }

    // Refresh observables
    courtSelections.refresh();
    updatedSlots.refresh();
  }

  // Add a new method to check if at least two players are selected
  bool hasMinimumPlayers() {
    int playerCount = 0;

    // Count non-null players in selectedFriends
    for (var friend in selectedFriends) {
      if (friend != null) {
        playerCount++;
      }
    }

    // Return true if at least 2 players are selected
    return playerCount >= 2;
  }

  // void updateCourtSelection(
  //     String courtId, {
  //       String? rate,
  //       String? timeSlot,
  //       String? game,
  //     }) {
  //   // Clear previous court selections if selecting a new court
  //   if (selectedCourtId.value != courtId && selectedCourtId.value.isNotEmpty) {
  //     courtSelections.clear();
  //     updatedSlots.clear();
  //   }
  //
  //   courtSelections.update(
  //     courtId,
  //         (current) {
  //       // Update rate if provided, otherwise keep current or default to "60 Mins"
  //       String newRate = rate ?? current.rate ?? "60 Mins";
  //
  //       // Clear time slots if rate is manually changed
  //       if (rate != null) {
  //         updatedSlots.clear();
  //       } else {
  //         // Copy current time slots if rate is not being changed
  //         updatedSlots = List.from(current.timeSlots);
  //       }
  //
  //       // Handle time slot selection
  //       if (timeSlot != null) {
  //         if (updatedSlots.contains(timeSlot)) {
  //           // Deselect if already selected
  //           updatedSlots.remove(timeSlot);
  //         } else if (updatedSlots.length < 2) {
  //           // Allow adding if under the limit (max 2 slots)
  //           updatedSlots.add(timeSlot);
  //         } else {
  //           // Show error if trying to add beyond limit
  //           Get.closeAllSnackbars();
  //           Get.snackbar(
  //             'Limit Reached',
  //             'You can select up to 2 time slots.',
  //             snackPosition: SnackPosition.TOP,
  //             margin: EdgeInsets.all(16),
  //             backgroundColor: Colors.redAccent,
  //             colorText: Colors.white,
  //           );
  //           return current; // Return unchanged if limit reached
  //         }
  //       }
  //
  //       // Auto-toggle rate based on number of slots
  //       if (updatedSlots.length == 1) {
  //         newRate = "60 Mins";
  //       } else if (updatedSlots.length == 2) {
  //         newRate = "120 Mins";
  //       } else if (updatedSlots.isEmpty && rate == null) {
  //         newRate = "60 Mins"; // Default to 60 Mins if no slots selected
  //       }
  //
  //       // If rate is manually set to 60 Mins and there are 2 slots, keep only the first slot
  //       if (newRate == "60 Mins" && updatedSlots.length > 1) {
  //         updatedSlots = [updatedSlots[0]];
  //         Get.snackbar(
  //           'Slot Adjusted',
  //           'Only one slot is allowed for 60 Mins. Extra slot removed.',
  //           snackPosition: SnackPosition.TOP,
  //           margin: EdgeInsets.all(16),
  //           backgroundColor: Colors.orange,
  //           colorText: Colors.white,
  //         );
  //       }
  //
  //       // Update Rate observable
  //       Rate.value = newRate;
  //
  //       return CourtSelection(
  //         rate: newRate,
  //         timeSlots: updatedSlots,
  //         game: game ?? current.game,
  //       );
  //     },
  //     ifAbsent: () {
  //       // Initialize new court selection
  //       final initialSlots = timeSlot != null ? [timeSlot] : [];
  //       final initialRate = rate ?? (initialSlots.length == 2 ? "120 Mins" : "60 Mins");
  //       Rate.value = initialRate;
  //       updatedSlots = List.from(initialSlots);
  //       return CourtSelection(
  //         rate: initialRate,
  //         timeSlots: timeSlot != null ? [timeSlot] : [],
  //         game: game ?? "Padel",
  //       );
  //     },
  //   );
  //
  //   // Update selectedCourtId only if a court is being actively selected
  //   if (courtId.isNotEmpty && (rate != null || timeSlot != null || game != null)) {
  //     selectedCourtId.value = courtId;
  //   }
  // }



  void showFriendsBottomSheet(BuildContext context, int slotIndex) {
    // Prevent modifying index 0 (reserved for current user)
    if (slotIndex == 0) {
      Get.snackbar('Info', 'This slot is reserved for you', snackPosition: SnackPosition.TOP);
      return;
    }

    // Controller for the search bar
    final TextEditingController searchController = TextEditingController();

    // void filterFriends(String query) {
    //   if (query.isEmpty) {
    //     filteredFriends.assignAll(friendsdata.value.data?.friends ?? []);
    //   } else {
    //     filteredFriends.assignAll(
    //       (friendsdata.value.data?.friends ?? []).where(
    //             (friend) => friend.fullName.toLowerCase().contains(query.toLowerCase()),
    //       ).toList(),
    //     );
    //   }
    // }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to adjust height for keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search friends...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,

                  ),
                  onChanged: (value) {
                    searchQuery.value = value;
                    searchQuery.refresh();
                    // Cancel the previous timer if it exists
                    if (debounce?.isActive ?? false) {
                      debounce?.cancel();
                    }
                    // Start a new timer
                    debounce = Timer(
                      const Duration(milliseconds: 500),
                          () {
                        // Call API after debounce duration
                        getFriendRequest();
                      },
                    );
                  },
                ),
              ).marginSymmetric(horizontal: 20,vertical: 20),
              Obx(
                    () => friendsdata.value.data?.friends?.length==0?SizedBox(height: 50,child: Center(child:  Text("No Friend Found"),),):ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendsdata.value.data?.friends?.length??0,
                  itemBuilder: (context, index) {
               final friend=friendsdata.value.data?.friends?[index];
                    return ListTile(
                      title: Row(
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network("${imageBaseUrl}${friend?.profilePic}",height: 30,width: 30,fit: BoxFit.cover, errorBuilder:
                              (context, error,
                              stackTrace) {
                            return Container(
                              color: AppColors
                                  .lightGrey,
                              child: Icon(
                                Icons
                                    .person, // Error image/icon
                                size: 30.sp,
                                color: AppColors
                                    .grey,
                              ),
                            );})),
                          Text(friend?.fullName ?? "").marginSymmetric(horizontal: 10),
                        ],
                      ),
                      onTap: () {
                        // Check if friend exists in selectedFriends array or is current user
                        bool friendExists = selectedFriends.any((selected) => selected?.sId == friend?.sId) ||
                            friend?.sId == currentUser?.sId;
                        if (friendExists) {
                          Get.snackbar(
                            'Error',
                            "${friend?.fullName} is already selected or is you",
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(seconds: 3),
                            margin: EdgeInsets.all(16),
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        } else {
                          selectedFriends[slotIndex] = friend;
                          selectedFriends.refresh();
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ).marginOnly(bottom: 20),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // Dispose of the search controller when the bottom sheet is closed
      searchController.dispose();
    });
  }

Future<void> getCourtDetail() async {
  selectedDate.value = DateTime.now();
  final now = DateTime.now();
  currentDate.value = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  loading.value = true;
  Get.closeAllSnackbars();
  try {
    final response = await _apiRepository.getCourtDetail({
      "game": selectedgame?.value ?? "Padel",
      "venueId": venueId?.value,
      "date": currentDate.value
    });
    if (response != null) {
      userdata.value = response;
      if (userdata.value?.data?.courts?.isNotEmpty ?? false) {
        final firstCourt = userdata.value!.data!.courts![0];
        selectedCourtId.value = firstCourt.sId ?? '';
        updateCourtSelection(firstCourt.sId ?? '', game: firstCourt.games ?? 'Padel');
      }
    }
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
  } finally {
    loading.value = false;
  }
}

void setSelectedButton(int value) {
  selectedButton.value = value;
}

void setSelectedButton2(int value) {
  selectedButton2.value = value;
}

void setProgressValue(double value) {
  progressValue.value = value;
}

void toggleCheckBox() {
  checkBox.value = !checkBox.value;
  // Reset selectedFriends but keep current user at index 0
  selectedFriends.assignAll(List<Friends?>.filled(4, null));
  selectedFriends[0] = currentUser;
  selectedFriends.refresh();
}

void setAskJoin(bool value) {
  askJoin.value = value;
}
}
