import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_call_controller.dart';

class VideoCallScreen extends GetView<VideoCallController> {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call')),
      body: Stack(
        children: [
          Center(child: _remoteVideo()),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(child: _localPreview()),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _localPreview() {
    return Obx(() {
      if (controller.agroaController.isJoined) {
        return AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: controller.agroaController.engine!,
            canvas: const VideoCanvas(uid: 0),
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget _remoteVideo() {
    return Obx(() {
      if (controller.agroaController.remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: controller.agroaController.engine!,
            canvas: VideoCanvas(uid: controller.agroaController.remoteUid),
            connection: RtcConnection(channelId: controller.channelController.text),
          ),
        );
      } else {
        return const Text('Waiting for remote user...', textAlign: TextAlign.center);
      }
    });
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => controller.agroaController.isJoined
                ? FloatingActionButton(
                    onPressed: controller.endCall,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end),
                  )
                : FloatingActionButton(
                    onPressed: controller.startCall,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.call),
                  )),
          ],
        ),
      ),
    );
  }
}
