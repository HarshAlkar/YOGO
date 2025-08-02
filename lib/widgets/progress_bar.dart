import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final double totalDuration;
  final double currentPosition;
  final VoidCallback? onSeek;
  final Color? progressColor;
  final Color? backgroundColor;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.totalDuration,
    required this.currentPosition,
    this.onSeek,
    this.progressColor,
    this.backgroundColor,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final currentDuration = Duration(seconds: currentPosition.toInt());
    final totalDurationFormatted = Duration(seconds: totalDuration.toInt());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Progress bar
          GestureDetector(
            onTapDown: onSeek != null ? (details) {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(details.globalPosition);
              final width = renderBox.size.width - 32; // Account for padding
              final relativePosition = localPosition.dx / width;
              // You can implement seek functionality here using relativePosition * totalDuration
            } : null,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        progressColor ?? Colors.blue[400]!,
                        progressColor ?? Colors.blue[600]!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Time display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(currentDuration),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _formatDuration(totalDurationFormatted),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 