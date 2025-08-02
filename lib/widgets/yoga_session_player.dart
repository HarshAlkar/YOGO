import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/yoga_models.dart';
import 'pose_image.dart';
import 'pose_text.dart';
import 'player_controls.dart';
import 'progress_bar.dart';

class YogaSessionPlayer extends StatefulWidget {
  final YogaSession session;

  const YogaSessionPlayer({super.key, required this.session});

  @override
  State<YogaSessionPlayer> createState() => _YogaSessionPlayerState();
}

class _YogaSessionPlayerState extends State<YogaSessionPlayer> {
  late AudioPlayer _audioPlayer;
  late AudioPlayer _backgroundPlayer;

  int _currentSegmentIndex = 0;
  int _currentLoopCount = 0;
  double _currentPosition = 0.0;
  bool _isPlaying = false;
  bool _isLoading = true;
  String _currentImageRef = '';
  String _currentText = '';

  Timer? _positionTimer;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    _audioPlayer = AudioPlayer();
    _backgroundPlayer = AudioPlayer();

    // Set up position tracking
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position.inMilliseconds / 1000.0;
        });
        _updateScriptDisplay();
      }
    });

    // Set up player state tracking
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });

        if (state.processingState == ProcessingState.completed) {
          _onSegmentComplete();
        }
      }
    });

    // Load and play the first segment
    await _loadCurrentSegment();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadCurrentSegment() async {
    if (_currentSegmentIndex >= widget.session.sequence.length) {
      _onSessionComplete();
      return;
    }

    final segment = widget.session.sequence[_currentSegmentIndex];
    final audioFileName = widget.session.assets.audio[segment.audioRef];

    if (audioFileName != null) {
      try {
        await _audioPlayer.setAsset('assest/audio/$audioFileName');

        // Set initial script display
        if (segment.script.isNotEmpty) {
          _currentImageRef = segment.script.first.imageRef;
          _currentText = segment.script.first.text;
        }

        _updateScriptDisplay();
      } catch (e) {
        print('Error loading audio: $e');
      }
    }
  }

  void _updateScriptDisplay() {
    if (_currentSegmentIndex >= widget.session.sequence.length) return;

    final segment = widget.session.sequence[_currentSegmentIndex];
    final currentTime = _currentPosition;

    // Find the active script entry
    ScriptEntry? activeScript;
    for (final script in segment.script) {
      if (script.isActiveAt(currentTime)) {
        activeScript = script;
        break;
      }
    }

    if (activeScript != null) {
      setState(() {
        _currentImageRef = activeScript!.imageRef;
        _currentText = activeScript!.text;
      });
    }
  }

  void _onSegmentComplete() {
    final segment = widget.session.sequence[_currentSegmentIndex];

    if (segment.isLoop) {
      _currentLoopCount++;
      if (_currentLoopCount < widget.session.metadata.defaultLoopCount) {
        // Repeat the loop segment
        _restartCurrentSegment();
      } else {
        // Move to next segment
        _currentLoopCount = 0;
        _currentSegmentIndex++;
        _loadCurrentSegment();
      }
    } else {
      // Move to next segment
      _currentSegmentIndex++;
      _loadCurrentSegment();
    }
  }

  void _restartCurrentSegment() {
    _audioPlayer.seek(Duration.zero);
    _audioPlayer.play();
  }

  void _onSessionComplete() {
    // Session completed
    setState(() {
      _isPlaying = false;
    });
    // You can navigate back or show completion screen
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _skipForward() {
    // Skip to next segment
    _currentSegmentIndex++;
    _currentLoopCount = 0;
    _loadCurrentSegment();
    if (_isPlaying) {
      _audioPlayer.play();
    }
  }

  void _skipBackward() {
    // Skip to previous segment
    if (_currentSegmentIndex > 0) {
      _currentSegmentIndex--;
      _currentLoopCount = 0;
      _loadCurrentSegment();
      if (_isPlaying) {
        _audioPlayer.play();
      }
    }
  }

  double get _totalDuration {
    double total = 0;
    for (final segment in widget.session.sequence) {
      if (segment.isLoop) {
        total += segment.durationSec * widget.session.metadata.defaultLoopCount;
      } else {
        total += segment.durationSec;
      }
    }
    return total;
  }

  double get _currentTotalPosition {
    double position = 0;
    for (int i = 0; i < _currentSegmentIndex; i++) {
      final segment = widget.session.sequence[i];
      if (segment.isLoop) {
        position +=
            segment.durationSec * widget.session.metadata.defaultLoopCount;
      } else {
        position += segment.durationSec;
      }
    }

    // Add current segment position
    if (_currentSegmentIndex < widget.session.sequence.length) {
      final segment = widget.session.sequence[_currentSegmentIndex];
      if (segment.isLoop) {
        position +=
            _currentPosition + (segment.durationSec * _currentLoopCount);
      } else {
        position += _currentPosition;
      }
    }

    return position;
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    _backgroundPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentSegment = _currentSegmentIndex < widget.session.sequence.length
        ? widget.session.sequence[_currentSegmentIndex]
        : null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.session.metadata.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (currentSegment != null)
                          Text(
                            currentSegment.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar
            ProgressBar(
              progress: _totalDuration > 0
                  ? _currentTotalPosition / _totalDuration
                  : 0,
              totalDuration: _totalDuration,
              currentPosition: _currentTotalPosition,
            ),

            const SizedBox(height: 20),

            // Image display
            Expanded(
              child: Center(
                child: PoseImage(
                  imageRef: _currentImageRef,
                  images: widget.session.assets.images,
                  width: 300,
                  height: 300,
                ),
              ),
            ),

            // Text display
            Container(
              padding: const EdgeInsets.all(16),
              child: PoseText(text: _currentText, isActive: true),
            ),

            // Player controls
            Container(
              padding: const EdgeInsets.all(16),
              child: PlayerControls(
                isPlaying: _isPlaying,
                onPlayPause: _togglePlayPause,
                onSkipForward: _skipForward,
                onSkipBackward: _skipBackward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
