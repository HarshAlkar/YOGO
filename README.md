# 🧘‍♀️ YOGO - Yoga Session App

A beautiful and intuitive Flutter application designed to guide users through yoga sessions with audio instructions and visual pose guidance.

## ✨ Features

- **Audio-Guided Sessions**: Professional voice instructions for each yoga pose
- **Visual Pose Guidance**: Clear images showing proper form for each pose
- **Interactive Player**: Custom controls for play, pause, and session navigation
- **Progress Tracking**: Real-time progress indicators during sessions
- **Smooth Animations**: Fluid transitions between poses and states
- **Cross-Platform**: Works on Android, iOS, and web platforms

## 🎯 Current Session: Cat-Cow Flow

The app currently features a **Cat-Cow Flow** session, a fundamental yoga sequence that:

- **Improves spinal mobility** and flexibility
- **Enhances breathing awareness** through coordinated movement
- **Relieves back tension** and promotes relaxation
- **Suitable for all levels** from beginners to advanced practitioners

### Session Structure:
- **Intro (23s)**: Preparation and setup instructions
- **Main Flow (45s loops)**: Cat-Cow pose transitions with breath guidance
- **Outro (15s)**: Cool-down and session completion

## 🛠️ Technology Stack

- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **Audio**: just_audio package for seamless audio playback
- **State Management**: Provider for efficient app state management
- **UI**: Material Design 3 with custom theming

## 📱 Screenshots

*[Screenshots will be added here]*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/HarshAlkar/YOGO.git
   cd YOGO
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── yoga_models.dart     # Data models for yoga sessions
├── screens/
│   ├── yoga_home.dart       # Main home screen
│   ├── yoga_player.dart     # Session player screen
│   └── yoga_preview.dart    # Session preview screen
├── services/
│   └── load_json.dart       # JSON data loading service
└── widgets/
    ├── player_controls.dart # Audio player controls
    ├── pose_image.dart      # Pose image display
    ├── pose_text.dart       # Instruction text display
    ├── progress_bar.dart    # Session progress indicator
    └── yoga_session_player.dart # Main session player widget

assest/
├── audio/                   # Audio files for sessions
├── images/                  # Pose images
└── poses.json              # Session configuration data
```

## 🎨 Customization

### Adding New Sessions

1. **Create audio files** for intro, loop, and outro
2. **Add pose images** to the `assest/images/` directory
3. **Update `poses.json`** with session configuration
4. **Test the session** using the app

### Session JSON Structure

```json
{
  "metadata": {
    "id": "session_id",
    "title": "Session Title",
    "category": "session_category",
    "defaultLoopCount": 4,
    "tempo": "slow/medium/fast"
  },
  "assets": {
    "images": {
      "pose1": "image1.png",
      "pose2": "image2.png"
    },
    "audio": {
      "intro": "intro.mp3",
      "loop": "loop.mp3",
      "outro": "outro.mp3"
    }
  },
  "sequence": [
    {
      "type": "segment",
      "name": "intro",
      "audioRef": "intro",
      "durationSec": 30,
      "script": [...]
    }
  ]
}
```

## 🤝 Contributing

We welcome contributions! Please feel free to submit issues and enhancement requests.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The yoga community for inspiration
- Contributors and testers

## 📞 Contact

**Developer**: Harsh Alkar  
**GitHub**: [@HarshAlkar](https://github.com/HarshAlkar)  
**Project Link**: [https://github.com/HarshAlkar/YOGO](https://github.com/HarshAlkar/YOGO)

---

⭐ **Star this repository if you find it helpful!**
