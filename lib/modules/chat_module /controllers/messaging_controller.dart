import 'package:badminton/modules/chat_module%20/models/ChatModels.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../repository/api_repository.dart';
import '../../../repository/endpoint.dart';
import '../../../repository/localstorage.dart';

class MessagesController extends GetxController {
  var selectedIndex = 0.obs; // Reactive variable for selectedIndex

  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage localStorage = Get.find<LocalStorage>();
  Rx<ChatMessages> chatmessages = ChatMessages().obs;
  RxBool loading = true.obs;
  IO.Socket? socket;

  @override
  void onInit() {
    super.onInit();
    getChatList();
    setupSocketConnection();
  }
  
  @override
  void onClose() {
    socket?.disconnect();
    socket?.dispose();
    super.onClose();
  }
  
  void setupSocketConnection() {
    final token = localStorage.getAuthToken();
    if (token == null || token.isEmpty) {
      debugPrint("Error: No valid token found for socket connection");
      return;
    }
    
    try {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setPath('/socket.io')
            .setQuery({'token': token})
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .enableAutoConnect()
            .build(),
      );
      
      socket!.onConnect((_) {
        debugPrint('Messaging socket connected successfully!');
      });
      
      socket!.on('new_message', (_) {
        // Refresh chat list when a new message is received
        getChatList();
      });
      
      socket!.onDisconnect((_) {
        debugPrint('Messaging socket disconnected');
      });
      
    } catch (e) {
      debugPrint('Socket connection error: $e');
    }
  }

  getChatList() async {
    loading.value = true;
    Get.closeAllSnackbars();
    try {
      final response = await _apiRepository.getchat(query: {
        "type": selectedIndex == 0 ? "single" : "group"
      });
      if (response != null) {
        chatmessages.value = response;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      loading.value = false;
    }
  }
  
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
