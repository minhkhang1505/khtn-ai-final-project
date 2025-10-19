import 'package:flutter/material.dart';

/// Navigation service for programmatic navigation without BuildContext
///
/// This service provides a convenient way to navigate without needing
/// BuildContext, which is especially useful in:
/// - ViewModels/BLoCs
/// - Services
/// - Middleware
/// - Error handlers
///
/// Usage:
/// 1. Initialize in main.dart: MaterialApp(navigatorKey: NavigationService.navigatorKey)
/// 2. Navigate anywhere: NavigationService.navigateTo('/route-name')
class NavigationService {
  // Prevent instantiation
  NavigationService._();

  /// Global navigator key for the app
  /// Must be set in MaterialApp.navigatorKey
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get the current navigator state
  static NavigatorState? get _navigator => navigatorKey.currentState;

  /// Get the current context
  static BuildContext? get context => navigatorKey.currentContext;

  /// Navigate to a named route
  ///
  /// [routeName] - The route name to navigate to
  /// [arguments] - Optional arguments to pass to the route
  ///
  /// Returns a Future that completes with the result of the navigation
  static Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return _navigator?.pushNamed(routeName, arguments: arguments);
  }

  /// Navigate to a named route and remove all previous routes
  ///
  /// [routeName] - The route name to navigate to
  /// [arguments] - Optional arguments to pass to the route
  ///
  /// Useful for login/logout flows
  static Future<dynamic>? navigateToAndRemoveUntil(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return _navigator?.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  /// Replace the current route with a new route
  ///
  /// [routeName] - The route name to navigate to
  /// [arguments] - Optional arguments to pass to the route
  ///
  /// Useful for replacing splash screen with home screen
  static Future<dynamic>? replaceWith(String routeName, {Object? arguments}) {
    return _navigator?.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pop the current route
  ///
  /// [result] - Optional result to return to the previous route
  static void goBack([dynamic result]) {
    if (canGoBack()) {
      _navigator?.pop(result);
    }
  }

  /// Pop until a specific route
  ///
  /// [routeName] - The route name to pop until
  static void popUntil(String routeName) {
    _navigator?.popUntil(ModalRoute.withName(routeName));
  }

  /// Pop until the first route
  static void popToRoot() {
    _navigator?.popUntil((route) => route.isFirst);
  }

  /// Check if we can go back
  static bool canGoBack() {
    return _navigator?.canPop() ?? false;
  }

  /// Show a dialog
  ///
  /// [builder] - The dialog widget builder
  /// [barrierDismissible] - Whether tapping outside dismisses the dialog
  static Future<T?> showDialogBox<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) async {
    final currentContext = context;
    if (currentContext == null) return null;

    return showDialog<T>(
      context: currentContext,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// Show a bottom sheet
  ///
  /// [builder] - The bottom sheet widget builder
  /// [isScrollControlled] - Whether the bottom sheet can be scrolled
  static Future<T?> showBottomSheetDialog<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
  }) async {
    final currentContext = context;
    if (currentContext == null) return null;

    return showModalBottomSheet<T>(
      context: currentContext,
      isScrollControlled: isScrollControlled,
      builder: builder,
    );
  }

  /// Show a snackbar
  ///
  /// [message] - The message to display
  /// [duration] - How long to show the snackbar
  /// [action] - Optional action button
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    final currentContext = context;
    if (currentContext == null) return;

    final messenger = ScaffoldMessenger.of(currentContext);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show a success snackbar
  static void showSuccess(String message) {
    showSnackBar(message: message, backgroundColor: Colors.green);
  }

  /// Show an error snackbar
  static void showError(String message) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }

  /// Show a warning snackbar
  static void showWarning(String message) {
    showSnackBar(message: message, backgroundColor: Colors.orange);
  }

  /// Show an info snackbar
  static void showInfo(String message) {
    showSnackBar(message: message, backgroundColor: Colors.blue);
  }
}
