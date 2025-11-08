import 'package:window_manager/window_manager.dart';

class WindowHelperFunctions {
  static Future<bool> isFullScreen() {
    return windowManager.isFullScreen();
  }

  static Future<void> applyFullScreenWindowOptions() async {
    await windowManager.maximize();
    await windowManager.focus();
  }

  static Future<void> removeFullScreenWindowOptions() async {
    await windowManager.unmaximize();
    await windowManager.focus();
  }

  static Future<void> toggleFullScreen() async {
    if (await windowManager.isFullScreen()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }
}
