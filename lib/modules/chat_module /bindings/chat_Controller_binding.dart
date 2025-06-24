import 'package:badminton/modules/chat_module%20/controllers/Chat_Controller.dart';
import 'package:get/get.dart';

import '../controllers/messaging_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}