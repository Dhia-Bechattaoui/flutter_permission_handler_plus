# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2026-06-11

### Fixed
- Fixed Android package directory path mismatch and package name consistency

### Changed
- Rewrote README.md for a cleaner, professional presentation

## [0.1.0] - 2026-06-11

### Added
- Real permission handling via `permission_handler` (requests, status, settings)
- Example app controls: batch requests, settings redirect toggle, retry slider, cache clear
- Example GIF embedded in README

### Changed
- Batch requests now run sequentially to avoid concurrent platform lock
- Calendar permission mapped to `calendarFullAccess`

### Fixed
- Removed deprecated/legacy lints; analyzer now clean
- Manifest permissions added for example app dialogs

## [0.0.2] - 2025-08-10

### Added
- Swift Package Manager support for macOS
- Comprehensive documentation for all public API elements
- Platform detection utilities
- Enhanced permission handling with better UX

### Changed
- Improved package structure and organization
- Enhanced static analysis compliance
- Better code formatting and linting

### Fixed
- Package description length compliance
- Constructor ordering and documentation
- Dependency sorting in pubspec.yaml

## [0.0.1] - 2025-08-10

### Added
- Initial release of Flutter Permission Handler Plus
- Basic permission handling functionality
- Cross-platform support (iOS, Android, Windows, macOS, Linux, Web)
- Plugin platform interface integration

[Unreleased]: https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/releases/tag/v0.1.0
[0.0.2]: https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/releases/tag/v0.0.2
[0.0.1]: https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/releases/tag/v0.0.1
