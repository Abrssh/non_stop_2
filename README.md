# Non Stop 2

A cross-platform Flutter application with support for Android, Windows, and Linux.

## Project Overview

Non Stop 2 is a Flutter application built to run seamlessly across multiple platforms. The project follows standard Flutter architecture and includes platform-specific configurations for optimal performance.

## Supported Platforms

- **Android**: Full support with Kotlin integration
- **Windows**: Native Windows application support
- **Linux**: GTK-based Linux application support

## Development Setup

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- For Android development:
  - Android SDK
  - JDK 8 or newer
- For Windows development:
  - Visual Studio with C++ desktop development workload
  - Windows 10 or newer
- For Linux development:
  - GTK development libraries
  - Clang

### Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Abrssh/non_stop_2.git
   ```

2. Navigate to the project directory:
   ```bash
   cd non_stop_2
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## Building for Production

### Android

```bash
flutter build apk --release
```

The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

### Windows

```bash
flutter build windows --release
```

The executable will be available in the `build/windows/runner/Release/` directory.

### Linux

```bash
flutter build linux --release
```

The executable will be available in the `build/linux/x64/release/bundle/` directory.

## Project Structure

- `android/`: Android-specific configuration and code
- `windows/`: Windows platform implementation
- `linux/`: Linux platform implementation
- `lib/`: Flutter application code (Dart)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Project Link: [https://github.com/Abrssh/non_stop_2](https://github.com/Abrssh/non_stop_2)
