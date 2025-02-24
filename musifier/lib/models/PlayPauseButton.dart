import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {
  final Function()? onPressed;
  final double size;

  const PlayPauseButton({
    Key? key,
    this.onPressed,
    this.size = 80.0,
  }) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlaying = !isPlaying;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
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
            isPlaying ? Icons.play_arrow : Icons.pause,
            color: Colors.white,
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}