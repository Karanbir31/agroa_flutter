import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../agro_controller.dart';

class VoiceCallController extends GetxController {
  final AgroaController agroaController = Get.find<AgroaController>();

  final channelController = TextEditingController(text: 'test_voice');
  final tokenController = TextEditingController();

  @override
  void onClose() {
    channelController.dispose();
    tokenController.dispose();
    super.onClose();
  }

  void startCall() {
    if (channelController.text.isNotEmpty) {
      agroaController.joinChannel(
        token: tokenController.text.trim(),
        channel: channelController.text.trim(),
      );
    } else {
      Get.snackbar("Error", "Channel name cannot be empty");
    }
  }

  void endCall() {
    agroaController.leaveChannel();
  }
}
