import 'package:flutter/material.dart';

class MusicPlayerProvider extends ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
