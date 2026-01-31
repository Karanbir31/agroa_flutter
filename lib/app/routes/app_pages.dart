import 'package:get/get.dart';
import '../modules/home/home_bindings.dart';
import '../modules/home/home_screen.dart';
import '../modules/auth/auth_bindings.dart';
import '../modules/auth/auth_screen.dart';
import '../modules/chat/chat_bindings.dart';
import '../modules/chat/chat_screen.dart';
import '../modules/voice_call/voice_call_bindings.dart';
import '../modules/voice_call/voice_call_screen.dart';
import '../modules/video_call/video_call_bindings.dart';
import '../modules/video_call/video_call_screen.dart';
import '../modules/splash/splash_bindings.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatScreen(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: Routes.VOICE_CALL,
      page: () => const VoiceCallScreen(),
      binding: VoiceCallBindings(),
    ),
    GetPage(
      name: Routes.VIDEO_CALL,
      page: () => const VideoCallScreen(),
      binding: VideoCallBindings(),
    ),
  ];
}
