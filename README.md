# KHTN AI Final Project

A clean, maintainable Flutter application following Clean Architecture and MVVM, with Provider for state management and clear separation of concerns (components, services, actions, reducers).

## Version

- App version: `1.0.0+1` (see `pubspec.yaml`)
- Dart SDK: `^3.9.2` (see `pubspec.yaml`)

## Tech Stack

- Flutter (stable)
- State Management: Provider
- Dependency Injection: get_it
- Networking: http
- Local Storage: shared_preferences
- Connectivity: internet_connection_checker_plus
- Utilities: equatable (value equality), dartz (Either for use cases)

## Architecture Overview

This project uses Clean Architecture layered approach combined with MVVM on the presentation layer.

- Domain (pure business rules)
  - Entities: core business objects
  - Repositories: contracts (interfaces)
  - Usecases: application-specific business logic
- Data (framework-dependent implementations)
  - Models: DTOs/serializers
  - Datasources: remote/local data access
  - Repositories: implement domain contracts, orchestrate datasources
- Core (cross-cutting)
  - Errors, network, usecase base, utilities, constants
- Presentation (MVVM)
  - Views: UI screens
  - ViewModels: UI logic (ChangeNotifier)
  - State: optional actions/reducers per feature for explicit state transitions
  - Common: shared widgets and styles
  - Services: UI services (navigation, toasts, etc.)
  - Routes: central routing

## Folder Structure

```
lib/
	core/
		constants/
		errors/
		network/
		usecases/
		utils/
	data/
		datasources/
			local/
			remote/
		models/
		repositories/
	domain/
		entities/
		repositories/
		usecases/
	di/
	presentation/
		common/
			styles/
			widgets/
		routes/
		services/
		state/
			counter/    # example placeholder (actions/reducer/state)
		viewmodels/
		views/
			home/
			splash/
```

Notes:

- Empty directories are tracked using `.gitkeep` to expose the structure publicly.
- You can keep this layer-first layout, or adopt a feature-first layout later if the app grows.

## How to Run

Prerequisites:

- Flutter SDK installed and configured (stable channel)
- Xcode / Android Studio as needed for target platforms

Setup and run:

```bash
# From project root
flutter pub get

# Run on connected device/emulator
flutter run

# Optional: analyze and test
flutter analyze
flutter test
```

## Contributing

This is a public repository — contributions are welcome!

1. Fork & clone the repo

2. Create a feature branch

```bash
git checkout -b feat/my-feature
```

3. Follow coding standards

- Keep layers separated (domain ↔ data ↔ presentation)
- Add/update unit tests when you change behavior
- Adhere to lints (see `analysis_options.yaml`)

4. Commit with Conventional Commits

Examples:

- `feat(auth): add login usecase`
- `fix(network): handle 401 response`
- `chore: track empty folders with .gitkeep`

Types: feat, fix, chore, refactor, docs, test, build, ci, perf, style.

5. Open a Pull Request

- Describe the change and motivation
- Link related issues
- Include screenshots/gifs for UI changes
- Ensure CI (analyze/tests) pass

## How to Add a New Feature (Guideline)

Example steps for feature "Profile":

- domain/
  - entities/profile_entity.dart
  - repositories/profile_repository.dart (interface)
  - usecases/get_profile.dart, update_profile.dart
- data/
  - models/profile_model.dart
  - datasources/remote/profile_remote_data_source.dart
  - repositories/profile_repository_impl.dart
- presentation/
  - views/profile/ (screens)
  - viewmodels/profile_view_model.dart (Provider/ChangeNotifier)
  - state/profile/ (actions.dart, reducer.dart, state.dart) — optional
  - routes: add route in router
- di/
  - Register data sources, repository impl, and usecases in the container

This keeps business logic testable and UI simple.

## License

TBD — If you plan to accept external contributions, consider adding a license (e.g., MIT) to clarify usage.
