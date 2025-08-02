import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback? onSkipForward;
  final VoidCallback? onSkipBackward;
  final bool showSkipControls;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    this.onSkipForward,
    this.onSkipBackward,
    this.showSkipControls = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showSkipControls && onSkipBackward != null)
            IconButton(
              onPressed: onSkipBackward,
              icon: const Icon(Icons.skip_previous),
              iconSize: 32,
              color: Colors.grey[600],
            ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: onPlayPause,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              iconSize: 40,
              padding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(width: 16),
          if (showSkipControls && onSkipForward != null)
            IconButton(
              onPressed: onSkipForward,
              icon: const Icon(Icons.skip_next),
              iconSize: 32,
              color: Colors.grey[600],
            ),
        ],
      ),
    );
  }
}
