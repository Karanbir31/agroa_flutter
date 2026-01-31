import 'package:get/get.dart';
import 'video_call_controller.dart';

class VideoCallBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());
  }
}
