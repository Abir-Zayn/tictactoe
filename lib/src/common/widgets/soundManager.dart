import 'package:audioplayers/audioplayers.dart';

class Soundmanager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> playSound(String soundPath, {double vol = 1.0}) async {
    if (!_isPlaying) {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(vol);
      await _audioPlayer.play(AssetSource(soundPath));
      _isPlaying = true;
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
