# Contributing to flutter_permission_handler_plus

Thank you for considering contributing to flutter_permission_handler_plus! We welcome contributions from the community.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, please include:

- **Description**: A clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: Flutter version, plugin version, platform (iOS/Android), device info
- **Logs**: Any relevant error logs or console output

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Description**: Clear description of the enhancement
- **Use Case**: Why this enhancement would be useful
- **Proposed Solution**: How you think it should work
- **Alternatives**: Any alternative solutions you've considered

### Code Contributions

1. **Fork the Repository**: Create a fork of the repository on GitHub

2. **Create a Branch**: Create a new branch for your feature or bug fix
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**: Implement your changes following the project's coding standards

4. **Add Tests**: Add tests for any new functionality

5. **Run Tests**: Ensure all tests pass
   ```bash
   flutter test
   ```

6. **Run Analysis**: Ensure code passes static analysis
   ```bash
   flutter analyze
   ```

7. **Update Documentation**: Update README and API documentation as needed

8. **Commit Changes**: Write clear, descriptive commit messages
   ```bash
   git commit -m "Add feature: improved error handling"
   ```

9. **Push Changes**: Push your branch to your fork
   ```bash
   git push origin feature/your-feature-name
   ```

10. **Create Pull Request**: Submit a pull request with a clear description

## Development Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus.git
   cd flutter_permission_handler_plus
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   cd example
   flutter pub get
   ```

3. **Run Example App**:
   ```bash
   cd example
   flutter run
   ```

## Coding Standards

### Dart Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format your code
- Follow the existing code style and conventions

### Documentation

- Document all public APIs with dartdoc comments
- Include code examples in documentation
- Update README.md for new features

### Testing

- Write unit tests for new functionality
- Ensure existing tests still pass
- Aim for good test coverage

### Commit Messages

Use clear, descriptive commit messages:

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

Examples:
```
feat: add support for notification permissions
fix: handle permanently denied permissions correctly
docs: update README with new usage examples
```

## Platform-Specific Guidelines

### Android

- Follow Android permission best practices
- Test on multiple Android API levels
- Handle permission changes in API 23+

### iOS

- Follow iOS permission guidelines
- Test on multiple iOS versions
- Handle permission changes properly

## Release Process

1. **Version Bump**: Update version in `pubspec.yaml` and `CHANGELOG.md`
2. **Testing**: Comprehensive testing on both platforms
3. **Documentation**: Update all relevant documentation
4. **Publish**: Release to pub.dev

## Code of Conduct

### Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment include:

- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by contacting the project team. All complaints will be reviewed and investigated promptly and fairly.

## Questions?

If you have questions about contributing, please:

1. Check the existing documentation
2. Search existing issues
3. Create a new issue with the `question` label
4. Contact the maintainers

Thank you for contributing to flutter_permission_handler_plus!
