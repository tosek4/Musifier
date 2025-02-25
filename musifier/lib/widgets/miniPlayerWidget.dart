import 'package:flutter/material.dart';
import 'package:musifier/providers/musicPlayerProvider.dart';

class MiniPlayer extends StatelessWidget {
  final String title;
  final String artist;
  final ImageProvider albumCover;

  const MiniPlayer({
    Key? key,
    required this.title,
    required this.artist,
    required this.albumCover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicPlayerProvider = MusicPlayerProvider();

    return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 10.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6156E2),
        borderRadius: BorderRadius.circular(16),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(10)),
              image: DecorationImage(
                image: albumCover,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Nunito-Regular'
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontFamily: 'Nunito-Bold'
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // TODO: Implement
          IconButton(
            onPressed: musicPlayerProvider.togglePlayPause,
            icon: Icon(
              musicPlayerProvider.player.playing ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}