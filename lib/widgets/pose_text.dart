import 'package:flutter/material.dart';

class PoseText extends StatefulWidget {
  final String text;
  final bool isActive;
  final TextStyle? style;
  final Duration transitionDuration;

  const PoseText({
    super.key,
    required this.text,
    required this.isActive,
    this.style,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  @override
  State<PoseText> createState() => _PoseTextState();
}

class _PoseTextState extends State<PoseText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(PoseText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: widget.isActive
                    ? Border.all(color: Colors.blue.withOpacity(0.3))
                    : null,
              ),
              child: Text(
                widget.text,
                style: (widget.style ?? Theme.of(context).textTheme.bodyLarge)?.copyWith(
                  fontSize: 18,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.normal,
                  color: widget.isActive
                      ? Colors.blue[800]
                      : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
} 