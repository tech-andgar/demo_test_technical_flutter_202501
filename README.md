# Demo Test Technical Flutter 202501

A Flutter application implementing a multi-step form with animations and state management.

## Setup Requirements

### Environment

- Dart SDK: ^3.6.0
- Flutter: Latest stable version
- IDE: VS Code or Android Studio

### Dependencies

Main packages used:

- flutter_riverpod: ^2.6.1 (State Management)
- go_router: ^14.3.0 (Navigation)

Development dependencies:

- flutter_lints: ^5.0.0
- dart_code_linter: ^1.1.5

## Getting Started

1. Clone the repository

    ```bash
    git clone https://github.com/tech-andgar/demo_test_technical_flutter_202501.git
    ```

2. Install dependencies

    ```bash
    flutter pub get
    ```

3. Run the application

    ```bash
    flutter run
    ```

## Architecture & Technical Decisions

### State Management

The application uses **Riverpod** as the state management solution. This choice was made for several reasons:

- **Type Safety**: Riverpod provides compile-time safety and better IDE support
- **Dependency Injection**: Easy to manage and inject dependencies
- **Testing**: Facilitates unit testing with easy mock providers
- **Code Organization**: Clear separation of UI and business logic through ViewModels

### Navigation

- Using **go_router** for declarative routing
- Custom transition animations between screens
- Maintains navigation history for proper back navigation

### Form Validation

- Real-time validation as user types
- Required field validation
- Custom toggle buttons for boolean inputs
- Disable/enable navigation based on form validity

### Project Structure

```
lib/
├── core/         /// Contains reusable components, routing, and theme configuration
│   ├── routes/
│   ├── theme/
│   └── widgets/  /// Reusable UI components divided into atoms and molecules
├── modules/      /// Feature-based modules containing screens and view models
│   └── forms/
│       ├── presentation/
│       └── view_model/
└── main.dart
```

## Technical Documentation

### Configuration Files

#### analysis_options.yaml

This file defines strict code analysis rules:

- Incorporates Flutter-specific linting rules
- Enforces strict mode for:
  - Type safety
  - Inference
  - Raw types
- Disables implicit casts and dynamic usage
- Includes custom lint rules from dart_code_linter

#### pubspec.yaml

Project configuration file containing:

- Dependencies:
  - flutter_riverpod: State management
  - go_router: Navigation
- Dev dependencies for testing and code quality
- Font configurations for multiple Futura font variants

### Core Components

Contains reusable components, routing, and theme configuration

#### Routes

- **names.dart**: Centralizes route name constants
- **pages.dart**: Configures GoRouter with route definitions
- **page_route_builder.dart**: Implements custom page transitions with slide animations

#### Theme

- Implements dark theme configuration
- Defines consistent typography using custom fonts
- Configures custom styles for:
  - Buttons
  - Input fields
  - Toggle buttons
  - Text styles

#### Widgets

Organized in atomic design pattern:

- **Atoms**: Basic UI components
  - CustomTextRequired: Text with required field indicator
- **Molecules**: Composite components
  - CustomButton: Reusable button component
  - CustomToggleButton: Two-state toggle component

### Code Quality

The project enforces high code quality standards through:

- Strict static analysis rules
- Comprehensive linting configuration
- Type safety enforcement
- Clear component hierarchy
- Consistent coding patterns

### UI/UX Considerations

1. **Custom Animations**
   - Slide transitions between pages
   - Direction-aware animations

2. **Accessibility**
   - Semantic labels for required fields
   - Clear error states
   - Proper contrast ratios

3. **Typography**
   - Multiple custom Futura font variants
   - Consistent text styling through theme

4. **Custom Widgets**
   - `CustomButton`: Reusable button component
   - `CustomToggleButton`: Two-state toggle component
   - `CustomTextRequired`: Text with required field indicator
