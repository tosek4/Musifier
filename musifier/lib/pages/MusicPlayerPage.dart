import 'package:flutter/material.dart';
import 'package:musifier/widgets/navBar.dart';
import 'package:musifier/pages/homePage.dart';
import 'package:musifier/pages/profilePage.dart';

import '../models/PlayPauseButton.dart';
import '../widgets/navBar.dart';


//todo slika,da se menvit vremeto do kaj e i kolku e dolga pesnata, valda navigacijata dobro rabotat


class MusicPlayerPage extends StatefulWidget {
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double _currentPosition = 50;
  bool isPlaying = false;
  final String currentTime = "1:25";
  final String duration = "3:15";

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 65),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 45),

            Container(
              height: 319,
              width: 319,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(36), // Add your desired radius here
              ),
              child: Center(
                child: Text(
                  "Album Cover",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Starboy",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "The Weeknd",
              style: TextStyle(color: Colors.white54, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(currentTime, style: TextStyle(color: Colors.white54)),
                  Text(duration, style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            Slider(
              min: 0,
              max: 100,
              value: _currentPosition,
              onChanged: (value) {
                setState(() {
                  _currentPosition = value;
                });
              },
            ),
            SizedBox(height: 40),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shuffle, color: Colors.white54, size: 40),
              SizedBox(width: 30),
              Icon(Icons.skip_previous, color: Colors.white, size: 40),
              SizedBox(width: 30),
              PlayPauseButton(
                size: 80.0,
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                  // Add your playback logic here
                },
              ),
              SizedBox(width: 30),
              Icon(Icons.skip_next, color: Colors.white, size: 40),
              SizedBox(width: 30),
              Icon(Icons.repeat, color: Colors.white, size: 40),
            ],
          ),
            Spacer(),
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
