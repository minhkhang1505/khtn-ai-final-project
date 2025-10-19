# Navigation System Documentation

## Overview

This navigation system provides a clean, maintainable, and scalable approach to routing in Flutter applications.

## Architecture

### 1. **AppRoutes** (`app_routes.dart`)

Centralized route name constants.

```dart
// Usage example
NavigationService.navigateTo(AppRoutes.home);
```

**Benefits:**

- Type-safe navigation
- IDE autocomplete support
- Easy to find and update routes
- Prevents typos

**How to extend:**

```dart
class AppRoutes {
  // Add new route constant
  static const String newFeature = '/new-feature';
  static const String nestedRoute = '/parent/child';
}
```

### 2. **RouteGenerator** (`route_generator.dart`)

Handles route generation and page transitions.

**Features:**

- Route argument handling
- Custom page transitions (fade, slide, scale, none)
- Error route for undefined routes
- Placeholder pages for development

**How to add a new route:**

```dart
case AppRoutes.newFeature:
  return _buildRoute(
    settings: settings,
    builder: (_) => const NewFeaturePage(),
    transition: RouteTransition.fade, // Optional custom transition
  );
```

**With arguments:**

```dart
case AppRoutes.details:
  if (args is Map<String, dynamic>) {
    return _buildRoute(
      settings: settings,
      builder: (_) => DetailsPage(
        id: args['id'],
        title: args['title'],
      ),
    );
  }
  return _errorRoute(settings.name ?? 'Unknown');
```

### 3. **NavigationService** (`navigation_service.dart`)

Provides navigation methods without requiring BuildContext.

**Usage in ViewModels/Services:**

```dart
class MyViewModel {
  void onLoginSuccess() {
    NavigationService.navigateToAndRemoveUntil(AppRoutes.home);
  }

  void showMessage() {
    NavigationService.showSuccess('Login successful!');
  }
}
```

**Available methods:**

- `navigateTo()` - Navigate to a route
- `replaceWith()` - Replace current route
- `navigateToAndRemoveUntil()` - Navigate and clear stack
- `goBack()` - Pop current route
- `popUntil()` - Pop until specific route
- `popToRoot()` - Pop to first route
- `showSuccess/Error/Warning/Info()` - Show snackbars
- `showDialogBox()` - Show dialogs
- `showBottomSheetDialog()` - Show bottom sheets

## Common Patterns

### 1. Simple Navigation

```dart
// From any widget
ElevatedButton(
  onPressed: () => NavigationService.navigateTo(AppRoutes.profile),
  child: Text('Go to Profile'),
)
```

### 2. Navigation with Arguments

```dart
// Navigate
NavigationService.navigateTo(
  AppRoutes.details,
  arguments: {'id': '123', 'title': 'Item Name'},
);

// Receive in target page
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final id = args['id'];
    final title = args['title'];
    // Use the arguments...
  }
}
```

### 3. Replace Route (Splash → Home)

```dart
// In splash screen after initialization
NavigationService.replaceWith(AppRoutes.home);
```

### 4. Clear Navigation Stack (Logout)

```dart
void logout() {
  // Clear user data...
  NavigationService.navigateToAndRemoveUntil(AppRoutes.login);
}
```

### 5. Nested Navigation

```dart
class AppRoutes {
  static const String userProfile = '/user/profile';
  static const String userSettings = '/user/settings';
  static const String adminDashboard = '/admin/dashboard';
}
```

## Best Practices

### 1. Route Naming

- Use meaningful, descriptive names
- Follow a consistent pattern (e.g., `/feature/action`)
- Group related routes with common prefixes

### 2. Error Handling

- Always validate route arguments
- Provide fallback for missing/invalid arguments
- Use the error route for undefined routes

### 3. Type Safety

```dart
// Create typed argument classes
class ProfileArguments {
  final String userId;
  final bool isEditable;

  ProfileArguments({required this.userId, this.isEditable = false});
}

// Use in navigation
NavigationService.navigateTo(
  AppRoutes.profile,
  arguments: ProfileArguments(userId: '123'),
);

// Receive safely
final args = ModalRoute.of(context)?.settings.arguments as ProfileArguments?;
if (args != null) {
  // Use args.userId, args.isEditable
}
```

### 4. Deep Linking (Future Enhancement)

```dart
// Can be extended to support:
// - URL-based navigation
// - Deep links from notifications
// - Universal links
```

## Testing

### Unit Testing Routes

```dart
test('should generate correct route for home', () {
  final route = RouteGenerator.generateRoute(
    RouteSettings(name: AppRoutes.home),
  );

  expect(route, isA<MaterialPageRoute>());
});
```

### Navigation Service Testing

```dart
testWidgets('should navigate to profile', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.home,
    ),
  );

  NavigationService.navigateTo(AppRoutes.profile);
  await tester.pumpAndSettle();

  // Verify navigation...
});
```

## Migration Guide

### From Old Navigation

```dart
// Old way
Navigator.pushNamed(context, '/profile');

// New way
NavigationService.navigateTo(AppRoutes.profile);
```

### Adding New Features

1. Add route constant in `app_routes.dart`
2. Create the page widget
3. Add route case in `route_generator.dart`
4. Use `NavigationService` to navigate

## Future Enhancements

- [ ] Route guards/middleware
- [ ] Deep linking support
- [ ] Route analytics/logging
- [ ] Nested navigation (tabs, drawer)
- [ ] Route caching/preloading
- [ ] Animation customization per route
- [ ] Route transition configuration
- [ ] Protected routes (auth required)

## Questions?

For issues or questions about the navigation system, please refer to:

- Flutter Navigation Documentation: https://docs.flutter.dev/ui/navigation
- This README
- Code comments in navigation files
