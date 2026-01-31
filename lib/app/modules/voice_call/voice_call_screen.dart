import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'voice_call_controller.dart';

class VoiceCallScreen extends GetView<VoiceCallController> {
  const VoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Call'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.channelController,
              decoration: const InputDecoration(
                labelText: 'Channel Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.tokenController,
              decoration: const InputDecoration(
                labelText: 'Token (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                controller.agroaController.isJoined
                    ? "Voice Call Connected: ${controller.channelController.text}"
                    : "Not Connected",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
            const SizedBox(height: 10),
            Obx(() {
              if (controller.agroaController.remoteUid != null) {
                return Text("Remote User: ${controller.agroaController.remoteUid}");
              } else {
                return const Text("Waiting for others...");
              }
            }),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  label: "Join",
                  color: Colors.green,
                  onPressed: () => controller.startCall(),
                ),
                _buildActionButton(
                  label: "Leave",
                  color: Colors.red,
                  onPressed: () => controller.endCall(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
