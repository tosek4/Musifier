import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> setAudio(int songId) async {
    await _player.stop();
    await _player.setUrl('https://musifier.circles-dev.tech/server/stream/$songId');
    notifyListeners();
  }

  void play() async {
    await _player.play();
    notifyListeners();
  }

  void pause() async {
    print('PAUSING>....');
    await _player.pause();
    notifyListeners();
  }

  void stop() async {
    await _player.stop();
    notifyListeners();
  }

  void togglePlayPause() async {
    print('PLAYER, ${_player.playing}');
    if(_player.playing) {
      pause();
      return;
    }

    play();
  }
}
