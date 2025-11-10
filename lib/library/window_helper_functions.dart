import 'package:client/main.dart';
import "package:flutter/material.dart";
import 'package:window_manager/window_manager.dart';

class WindowHelperFunctions {
  static Future<bool> isFullScreen() {
    return windowManager.isFullScreen();
  }

  static Future<void> applyFullScreenWindowOptions() async {
    await windowManager.setResizable(true);
    await windowManager.maximize();
    await windowManager.setResizable(false);
    await windowManager.focus();
  }

  static Future<void> removeFullScreenWindowOptions() async {
    await windowManager.setResizable(true);
    await windowManager.unmaximize();
    await windowManager.setSize(REGISTRATION_WINDOW_SIZE);
    await windowManager.setResizable(false);
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
