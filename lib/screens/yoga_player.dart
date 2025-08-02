import 'package:flutter/material.dart';
import '../models/yoga_models.dart';
import '../widgets/yoga_session_player.dart';

class YogaPlayer extends StatelessWidget {
  final YogaSession session;

  const YogaPlayer({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return YogaSessionPlayer(session: session);
  }
} 