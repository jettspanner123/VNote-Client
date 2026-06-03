import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final current = AudioService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(AppSounds sound, {double volume = 1.0, bool isLoop = false}) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setVolume(volume);
      await _audioPlayer.setReleaseMode(isLoop ? ReleaseMode.loop : ReleaseMode.release);

      await _audioPlayer.play(AssetSource(sound.path));
    } catch (e) {
      print('Error playing sound ${sound.name}: $e');
    }
  }
}

enum AppSounds { MONEY_TRANSFERED_SUCCESSFUL }

extension AppSoundPath on AppSounds {
  String get path {
    switch (this) {
      case AppSounds.MONEY_TRANSFERED_SUCCESSFUL:
        return "sounds/money_success.wav";
    }
  }
}
