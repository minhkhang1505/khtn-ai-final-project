/// Centralized route names for the application
///
/// This class contains all route name constants used throughout the app.
/// Benefits:
/// - Type-safe route navigation
/// - Easy to find and update route names
/// - Prevents typos in route strings
/// - Auto-complete support in IDE
class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  // Root routes
  static const String splash = '/';
  static const String home = '/home';
  static const String main = '/main'; // Main page with bottom navigation

  // Auth routes (example - can be extended)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verificationEmail = '/auth/register/verification-email';

  // Profile routes (example - can be extended)
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';

  // Feature routes (example - can be extended)
  static const String details = '/details';

  /// Get all route names as a list
  /// Useful for debugging or logging
  static List<String> get allRoutes => [
    splash,
    home,
    main,
    login,
    register,
    forgotPassword,
    profile,
    editProfile,
    settings,
    details,
  ];
}
