import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;
  bool get isPlaying => _player.playing;

  MusicPlayerProvider() {
    _player.playerStateStream.listen((state) {
      notifyListeners();
    });
  }

  Future<void> setAudio(int songId) async {
    await _player.setUrl('https://musifier.circles-dev.tech/server/stream/$songId');
    notifyListeners();
  }

  void togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    notifyListeners();
  }
}
