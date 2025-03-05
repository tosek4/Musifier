import 'package:flutter/material.dart';
import 'package:musifier/providers/musicPlayerProvider.dart';
import 'package:musifier/widgets/navBar.dart';
import 'package:musifier/pages/homePage.dart';
import 'package:musifier/pages/profilePage.dart';
import '../models/PlayPauseButton.dart';
import '../models/song.dart';
import 'package:provider/provider.dart';

String formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}

class MusicPlayerPage extends StatefulWidget {
  final Song? song;
  final int? songId;

  MusicPlayerPage({this.song, required this.songId});

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double _currentPosition = 0;
  late int _durationInSeconds;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _durationInSeconds = (widget.song?.duration ?? 0) ~/ 1000;

    final musicPlayerProvider = Provider.of<MusicPlayerProvider>(context, listen: false);
    musicPlayerProvider.setAudio(widget.songId!);

    musicPlayerProvider.player.positionStream.listen((position) {
      setState(() {
        _currentPosition = position.inSeconds.toDouble();
      });
    });

    musicPlayerProvider.player.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  void _togglePlayPause() {
    final musicPlayerProvider = Provider.of<MusicPlayerProvider>(context, listen: false);
    musicPlayerProvider.togglePlayPause();
  }

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);
    final formattedCurrentTime = formatDuration(_currentPosition.toInt());
    final formattedDuration = formatDuration(_durationInSeconds);

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 10) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B37),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 300,
              child: Image.network(
                widget.song!.image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.song!.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.song!.artists,
              style: const TextStyle(color: Colors.white54, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedCurrentTime, style: const TextStyle(color: Colors.white54)),
                  Text(formattedDuration, style: const TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            Slider(
              min: 0,
              max: _durationInSeconds.toDouble(),
              value: _currentPosition.toDouble(),
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) {
                setState(() {
                  _currentPosition = value;
                });
                musicPlayerProvider.player.seek(Duration(seconds: value.toInt()));
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shuffle, color: Colors.white54, size: 40),
                const SizedBox(width: 30),
                const Icon(Icons.skip_previous, color: Colors.white, size: 40),
                const SizedBox(width: 30),
                PlayPauseButton(
                  size: 80.0,
                  onPressed: _togglePlayPause,
                  isPlaying: musicPlayerProvider.isPlaying,
                ),
                const SizedBox(width: 30),
                const Icon(Icons.skip_next, color: Colors.white, size: 40),
                const SizedBox(width: 30),
                const Icon(Icons.repeat, color: Colors.white, size: 40),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _onNavItemTapped(0),
              child: NavigationWidget(currentIndex: 1),
            ),
          ],
        ),
      ),
    );
  }
}
