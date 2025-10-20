# Project: Weather App (tiempoapp)

## Project Overview

This is a Flutter mobile application for Android and iOS, likely intended to be a weather application given the project name "tiempoapp".

The project follows a **Clean Architecture** pattern, separating concerns into `core` and `features` directories. This structure promotes maintainability, scalability, and testability.

*   **Core:** Contains shared functionalities like error handling (`lib/core/error`), network utilities (`lib/core/network`), and base classes for use cases (`lib/core/usecases`).
*   **Features:** This directory is intended to hold the different features of the application (e.g., weather forecast, location search). It is currently empty.

The project uses the following key dependencies:

*   `dartz`: For functional programming patterns, enabling robust error handling through `Either` and `Option` types.
*   `equatable`: To simplify object equality checks.

## Building and Running

### 1. Install Dependencies

To install the necessary dependencies, run the following command in the project's root directory:

```sh
flutter pub get
```

### 2. Run the Application

To run the application on a connected device or emulator, use the following command:

```sh
flutter run
```

### 3. Run Tests

To execute the project's test suite, run:

```sh
flutter test
```

## Development Conventions

*   **Coding Style:** The project adheres to the standard Dart and Flutter linting rules provided by the `flutter_lints` package. Custom linting rules can be configured in the `analysis_options.yaml` file.
*   **Architecture:** New features should be developed within the `lib/features` directory, following the principles of Clean Architecture. Each feature should have its own domain, data, and presentation layers.
*   **State Management:** (TODO) The current boilerplate code in `main.dart` uses `StatefulWidget`, but a more scalable state management solution (like BLoC or Provider) is expected to be implemented as the application grows.
