

class YogaSession {
  final Metadata metadata;
  final Assets assets;
  final List<Segment> sequence;

  YogaSession({
    required this.metadata,
    required this.assets,
    required this.sequence,
  });

  factory YogaSession.fromJson(Map<String, dynamic> json) {
    return YogaSession(
      metadata: Metadata.fromJson(json['metadata']),
      assets: Assets.fromJson(json['assets']),
      sequence: (json['sequence'] as List)
          .map((segment) => Segment.fromJson(segment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      'assets': assets.toJson(),
      'sequence': sequence.map((segment) => segment.toJson()).toList(),
    };
  }
}

class Metadata {
  final String id;
  final String title;
  final String category;
  final int defaultLoopCount;
  final String tempo;

  Metadata({
    required this.id,
    required this.title,
    required this.category,
    required this.defaultLoopCount,
    required this.tempo,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      defaultLoopCount: json['defaultLoopCount'],
      tempo: json['tempo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'defaultLoopCount': defaultLoopCount,
      'tempo': tempo,
    };
  }
}

class Assets {
  final Map<String, String> images;
  final Map<String, String> audio;

  Assets({
    required this.images,
    required this.audio,
  });

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      images: Map<String, String>.from(json['images']),
      audio: Map<String, String>.from(json['audio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
      'audio': audio,
    };
  }
}

class Segment {
  final String type;
  final String name;
  final String audioRef;
  final int durationSec;
  final List<ScriptEntry> script;

  Segment({
    required this.type,
    required this.name,
    required this.audioRef,
    required this.durationSec,
    required this.script,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      type: json['type'],
      name: json['name'],
      audioRef: json['audioRef'],
      durationSec: json['durationSec'],
      script: (json['script'] as List)
          .map((script) => ScriptEntry.fromJson(script))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'audioRef': audioRef,
      'durationSec': durationSec,
      'script': script.map((script) => script.toJson()).toList(),
    };
  }

  bool get isLoop => type == 'loop';
}

class ScriptEntry {
  final String text;
  final double startSec;
  final double endSec;
  final String imageRef;

  ScriptEntry({
    required this.text,
    required this.startSec,
    required this.endSec,
    required this.imageRef,
  });

  factory ScriptEntry.fromJson(Map<String, dynamic> json) {
    return ScriptEntry(
      text: json['text'],
      startSec: json['startSec'].toDouble(),
      endSec: json['endSec'].toDouble(),
      imageRef: json['imageRef'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'startSec': startSec,
      'endSec': endSec,
      'imageRef': imageRef,
    };
  }

  bool isActiveAt(double currentTime) {
    return currentTime >= startSec && currentTime <= endSec;
  }
} 