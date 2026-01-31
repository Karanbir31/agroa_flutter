import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'app/core/utils/permission_handler.dart';
import 'main.dart';

class AgroaController extends GetxController {
  final String _tag = 'AgroaController';
  RtcEngine? _engine;

  final _remoteUid = RxnInt();
  int? get remoteUid => _remoteUid.value;

  final _isJoined = false.obs;
  bool get isJoined => _isJoined.value;

  final _isVideoEnabled = false.obs;
  bool get isVideoEnabled => _isVideoEnabled.value;

  @override
  void onClose() {
    leaveChannel();
    super.onClose();
  }

  /// Public function to join a channel.
  /// [isVideo] determines if camera should be enabled.
  Future<void> joinChannel({
    required String token,
    required String channel,
    bool isVideo = false,
  }) async {
    _isVideoEnabled.value = isVideo;

    // 1. Check and Request Permissions
    bool hasPermissions = await PermissionUtil.requestAppPermissions();
    if (!hasPermissions) {
      debugPrint("$_tag Permissions not granted. Cannot join channel.");
      return;
    }

    // 2. Initialize Engine if not already done
    if (_engine == null) {
      await _initializeAgoraEngine();
      _setupEventHandlers();
    }

    // 3. Join the Channel
    try {
      if (isVideo) {
        await _engine!.enableVideo();
        await _engine!.startPreview();
      } else {
        await _engine!.disableVideo();
      }

      await _engine!.joinChannel(
        token: token,
        channelId: channel,
        options: ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: isVideo,
          publishMicrophoneTrack: true,
          publishCameraTrack: isVideo,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
        uid: 0,
      );
    } catch (e) {
      debugPrint("$_tag Error joining channel: $e");
    }
  }

  /// Public function to leave the channel and release resources.
  Future<void> leaveChannel() async {
    if (_engine == null) return;
    try {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
      _isJoined.value = false;
      _remoteUid.value = null;
      _isVideoEnabled.value = false;
      debugPrint("$_tag Left channel and engine released");
    } catch (e) {
      debugPrint("$_tag Error cleaning up Agora engine: $e");
    }
  }

  // Set up the Agora RTC engine instance
  Future<void> _initializeAgoraEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(
      RtcEngineContext(
        appId: agroaAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  // Register an event handler for Agora RTC
  void _setupEventHandlers() {
    if (_engine == null) return;
    
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("$_tag Local user ${connection.localUid} joined");
          _isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("$_tag Remote user $remoteUid joined");
          _remoteUid.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("$_tag Remote user $remoteUid left");
          _remoteUid.value = null;
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          debugPrint("$_tag Left channel event");
        },
      ),
    );
  }

  RtcEngine? get engine => _engine;
}
