import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final Function()? onPressed;
  final double size;
  final bool isPlaying;

  const PlayPauseButton({
    Key? key,
    required this.onPressed,
    required this.isPlaying,
    this.size = 80.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF5433FF),
              Color(0xFF6E47FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
