# StudyConnect

A Flutter application that helps students connect, collaborate, and study together.

## Features

- 👥 **Study Rooms** - Join or create virtual study rooms
- 💬 **Chat** - Real-time messaging with peers
- 📞 **Calls** - Voice and video calling support
- 🌍 **Translation** - Multi-language support
- 🎨 **Themes** - Dark and light mode options
- 🔐 **Privacy** - Secure and private connections
- 💭 **Feelings** - Share and track student feelings/mood

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode

### Installation

1. Clone the repository:
```bash
git clone https://github.com/sharvaridhopte22-afk/Study-connect-.git
cd Study-connect-
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/               # UI screens
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   ├── rooms_screen.dart
│   └── profile_screen.dart
├── services/              # Backend services
│   ├── auth_service.dart
│   ├── chat_service.dart
│   └── call_service.dart
├── models/                # Data models
└── widgets/               # Reusable widgets
```

## Dependencies

- **provider** - State management
- **http** - API calls
- **socket_io_client** - Real-time communication
- **image_picker** - Image selection
- **agora_rtc_engine** - Video/Audio calls
- **intl** - Internationalization

## Contributing

1. Create a new branch: `git checkout -b feature/your-feature`
2. Commit your changes: `git commit -m 'Add your feature'`
3. Push to the branch: `git push origin feature/your-feature`
4. Create a Pull Request

## License

This project is open source and available under the MIT License.

## Support

For issues or questions, please create an issue on GitHub.
