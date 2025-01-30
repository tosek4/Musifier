import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musifier/auth/auth.dart';
import 'package:musifier/widgets/navBar.dart';
import '../widgets/boxSong.dart';
import '../widgets/listSong.dart';

class Song {
  final String title;
  final String artist;
  final String info;
  final String imageUrl;

  Song({
    required this.title,
    required this.artist,
    required this.info,
    required this.imageUrl,
  });
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  final int _currentIndex = 0;

  // Mock list of songs for "New Releases"
  // TODO: Fetch from backend
  final List<Song> newReleases = [
    Song(
      title: 'The Triangle',
      artist: 'Artist 1',
      info: '20m / streams',
      imageUrl: 'assets/da.png',
    ),
    Song(
      title: 'Dune Of Visa',
      artist: 'Artist 2',
      info: '15m / streams',
      imageUrl: 'assets/da.png',
    ),
    Song(
      title: 'Risktail',
      artist: 'Artist 3',
      info: '10m / streams',
      imageUrl: 'assets/da.png',
    ),
  ];

  // Mock list of songs for "Recommend for You"
  // TODO: Fetch from backend
  final List<Song> recommendForYou = [
    Song(
      title: 'StarBoy',
      artist: 'The Weeknd',
      info: '20m / streams',
      imageUrl: 'assets/da.png',
    ),
    Song(
      title: 'The Stranger Inside You',
      artist: 'Jeane Lebras',
      info: '60.8k / streams',
      imageUrl: 'assets/da.png',
    ),
    Song(
      title: 'Edwall of Beauty Mind',
      artist: 'Jacob Givson',
      info: '44.3k / streams',
      imageUrl: 'assets/da.png',
    ),
    Song(
      title: 'Rockstar',
      artist: 'Post Malone',
      info: '230m / streams',
      imageUrl: 'assets/da.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      backgroundColor: const Color(0xFF1B1B37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: const Text(
                  'MUSIFIER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'New Releases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-Regular',
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: newReleases.map((song) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: ContentBox(
                        image: AssetImage(song.imageUrl),
                        text: song.title,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommend for you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-Regular',
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: recommendForYou.map((song) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: MusicCard(
                          image: AssetImage(song.imageUrl),
                          title: song.title,
                          artist: song.artist,
                          info: song.info,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
}
