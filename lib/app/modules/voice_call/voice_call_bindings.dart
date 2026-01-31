import 'package:get/get.dart';
import 'voice_call_controller.dart';

class VoiceCallBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}
