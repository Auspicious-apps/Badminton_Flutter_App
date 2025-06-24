import 'dart:convert';

import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../models/ChatMessageList.dart';
import '../models/ChatModels.dart';
import '../models/messages.dart' show MessageChat;

class ChatController extends GetxController {
  // Reactive state for chat messages and UI
  final Rx<ChatMessagesList> chatMessages = ChatMessagesList().obs;
  final Rx<Messages> sendMessageData = Messages().obs;
  final RxBool loading = true.obs;
  final RxString typingUser = ''.obs; // To track typing status
  final RxSet<String> onlineUsers = <String>{}.obs;
  IO.Socket? socket;
  final LocalStorage localStorage = Get.find<LocalStorage>();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final RxString chatId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {

       chatId.value = Get.arguments["id"] ?? "";
      debugPrint("Initializing with chat ID: ${chatId.value}");

      getChatList(chatId.value);
      joinChat( chatId.value); // Join chat on initialization
    }
    socketConnection();
  }

  @override
  void onClose() {
    socket?.emit('leave_chat', Get.arguments?["id"]);
    socket?.disconnect();
    socket?.dispose();
    debugPrint('Socket disconnected and disposed');
    super.onClose();
  }

  void socketConnection() {
    makeSocketConnection((connected) {
      debugPrint("Socket connection ${connected ? 'established' : 'failed'}");
      if (connected && Get.arguments != null) {
        joinChat(Get.arguments["id"] ?? "");
      }
    });
  }

  void makeSocketConnection(Function(bool connected) onConnected) {
    if (socket != null && socket!.connected) {
      debugPrint('Socket already connected');
      onConnected(true);
      return;
    }

    final token = localStorage.getAuthToken();
    if (token == null || token.isEmpty) {
      debugPrint("Error: No valid token found");
      onConnected(false);
      Get.snackbar('Error', 'No valid authentication token found');
      return;
    }

    debugPrint("Socket token: $token");

    try {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setPath('/socket.io')
            .setQuery({'token': token})
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(30000)
            .enableAutoConnect()
            .enableReconnection()
            .build(),
      );

      _setupListeners(onConnected);
      debugPrint("Socket connection initialized");
    } catch (e) {
      debugPrint('Connection error: $e');
      onConnected(false);
      Get.snackbar('Connection Error', 'Failed to connect: $e');
    }
  }

  void _setupListeners(Function(bool connected) onConnected) {
    socket!.onConnect((_) {
      debugPrint('Socket connected successfully!');
      onConnected(true);
    });

    socket!.on('connection_success', (data) {
      debugPrint('Connection success: $data');
    });

    socket!.onDisconnect((reason) {
      debugPrint('Socket disconnected: $reason');
      onlineUsers.clear();
      socket!.connect();
    });

    socket!.onConnectError((error) {
      debugPrint('Connection error: $error');
      onConnected(false);
      Get.snackbar('Connection Error', 'Failed to connect: $error');
    });

    socket!.onError((data) {
      debugPrint('Socket error: $data');
      Get.snackbar('Socket Error', 'Error: $data');
    });

    socket!.on('chat_message', (data) {
      debugPrint('Chat message received: ${data["message"]}');

      // Extract message data and update UI
      final messageData = data["message"];
      if (messageData != null) {
        final sender = messageData["sender"] != null
            ? Participant.fromJson(messageData["sender"])
            : null;

        List<ReadBy> readByList = [];
        if (messageData["readBy"] != null) {
          if (messageData["readBy"] is List) {
            readByList = List<ReadBy>.from(
              (messageData["readBy"] as List).map((x) {
                return x is Map<String, dynamic> ? ReadBy.fromJson(x) : ReadBy(sId: x.toString());
              })
            );
          } else {
            // Handle case where readBy might be a single string or other type
            readByList = [ReadBy(sId: messageData["readBy"].toString())];
          }
        }

        final tempMessage = Messages(
          sender: sender,
          content: messageData["content"],
          contentType: messageData["contentType"],
          createdAt: messageData["createdAt"],
          readBy: readByList,
          sId: messageData["_id"],
        );

        chatMessages.value.data?.messages?.add(tempMessage);
        chatMessages.refresh();
      }
    });

    socket!.on('message_received', (data) {
      debugPrint('Message received acknowledgment: $data');

      final messageData = data["message"];
      if (messageData == null) return;

      Participant? sender;
      if (messageData["sender"] != null) {
        sender = messageData["sender"] is Map<String, dynamic>
            ? Participant.fromJson(messageData["sender"])
            : Participant(sId: messageData["sender"].toString());
      }

      List<ReadBy> readByList = [];
      if (messageData["readBy"] != null) {
        if (messageData["readBy"] is List) {
          readByList = List<ReadBy>.from(
            (messageData["readBy"] as List).map((x) {
              return x is Map<String, dynamic> ? ReadBy.fromJson(x) : ReadBy(sId: x.toString());
            })
          );
        } else {
          // Handle case where readBy might be a single string or other type
          readByList = [ReadBy(sId: messageData["readBy"].toString())];
        }
      }

      // Create a Messages object from the received data
      final tempMessage = Messages(
        sender: sender,
        content: messageData["content"],
        contentType: messageData["contentType"],
        createdAt: messageData["createdAt"],
        readBy: readByList,
        sId: messageData["_id"],
      );

      // Add the message to the list and refresh
      chatMessages.value.data?.messages?.add(tempMessage);
      chatMessages.refresh();
    });

    socket!.on('user_typing', (data) {
      debugPrint('User typing: $data');
      if (data is Map<String, dynamic> && data['chatId'] == Get.arguments?["id"]) {
        typingUser.value = data['isTyping'] == true ? data['userId'] ?? '' : '';
      }
    });

    socket!.on('online_users', (data) {
      debugPrint('Online users: $data');
      if (data is List) {
        onlineUsers.assignAll(List<String>.from(data));
      }
    });

    socket!.onAny((event, data) {
      debugPrint('Socket event received: $event, Data: ${jsonEncode(data)}');




    });
  }

  void joinChat(String chatId) {
    // loading.value=false;
    if (socket?.connected == true && chatId.isNotEmpty) {
      socket?.emit('join_chat', chatId);
      debugPrint('Joined chat: $chatId');
    }
  }

  void leaveChat(String chatId) {
    if (socket?.connected == true && chatId.isNotEmpty) {
      socket?.emit('leave_chat', chatId);
      debugPrint('Left chat: $chatId');
    }
  }

  Future<void> getChatList(String id) async {
    if (id.isEmpty) {
      Get.snackbar('Error', 'Invalid chat ID');
      return;
    }

    Get.closeAllSnackbars();
    try {
      final response = await _apiRepository.getchatList(Id: id);
      if (response != null && response.success == true) {
        chatMessages.value = response;
        loading.value = false;
      } else {
        loading.value = false;
        Get.snackbar('Error', response?.message ?? 'Failed to fetch chat');
      }
    } catch (e) {
      loading.value = false;
      debugPrint('Error fetching chat list: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  void sendMessage(String chatId, String content) async {

    Map<String, dynamic> requestModel;

    // Check if we're in an existing chat or creating a new one

      // Existing chat
      requestModel = AuthRequestModel.MessageRequest(
        chatId: chatId,
        content: content
      );

      // Optimistically add message to UI
      // final tempMessage = Messages(
      //   sender: chatMessages.value.data?.participants?.firstWhere(
      //     (p) => p.sId == chatMessages.value.myId,
      //     orElse: () => Participant()
      //   ),
      //   content: content,
      //   contentType: 'text',
      //   createdAt: DateTime.now().toIso8601String(),
      //   readBy: [ReadBy(sId: chatMessages.value.myId)],
      // );
      //
      // chatMessages.value.data?.messages?.add(tempMessage);
      // chatMessages.refresh();

    try {
      final response = await _apiRepository.MessageApi(dataBody: requestModel);
      sendMessageData.value = response;

      // If this was a new chat, we should refresh the chat list
      if (chatMessages.value.data == null) {
        getChatList(chatId);
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message');
    }

  }

  // void setTypingStatus(String chatId, bool isTyping) {
  //   if (socket?.connected == true && chatId.isNotEmpty) {
  //     socket?.emit('typing', {
  //       'chatId': chatId,
  //       'isTyping': isTyping,
  //     });
  //     debugPrint('Typing status emitted: $isTyping for chat $chatId');
  //   }
  }

  // bool isUserOnline(String userId) {
  //   return onlineUsers.contains(userId);
  // }

