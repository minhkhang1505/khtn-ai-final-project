import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/views/splash/splash_page.dart';
import 'package:khtn_ai_final_project/presentation/views/home/home_page.dart';
import 'package:khtn_ai_final_project/presentation/views/main/main_page.dart';

/// Centralized route generator for the application
///
/// This class handles all route generation and navigation logic.
/// Benefits:
/// - Single source of truth for route configuration
/// - Easy to add route transitions
/// - Support for route arguments
/// - Custom page transitions
class RouteGenerator {
  // Prevent instantiation
  RouteGenerator._();

  /// Generate route based on route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Extract arguments if any
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(
          settings: settings,
          builder: (_) => const SplashPage(),
        );

      case AppRoutes.home:
        return _buildRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );

      case AppRoutes.main:
        return _buildRoute(
          settings: settings,
          builder: (_) => const MainPage(),
        );

      // Example of route with arguments
      case AppRoutes.details:
        if (args is Map<String, dynamic>) {
          return _buildRoute(
            settings: settings,
            builder: (_) => _buildPlaceholderPage(
              title: 'Details',
              message: 'ID: ${args['id']}',
            ),
          );
        }
        return _errorRoute(settings.name ?? 'Unknown');

      // Auth routes (placeholder)
      case AppRoutes.login:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Login'),
        );

      case AppRoutes.register:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Register'),
        );

      case AppRoutes.forgotPassword:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Forgot Password'),
        );

      // Profile routes (placeholder)
      case AppRoutes.profile:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Profile'),
        );

      case AppRoutes.editProfile:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Edit Profile'),
        );

      case AppRoutes.settings:
        return _buildRoute(
          settings: settings,
          builder: (_) => _buildPlaceholderPage(title: 'Settings'),
        );

      default:
        return _errorRoute(settings.name ?? 'Unknown');
    }
  }

  /// Build a standard route with optional custom transition
  static Route<dynamic> _buildRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
    RouteTransition? transition,
  }) {
    switch (transition) {
      case RouteTransition.fade:
        return _fadeRoute(settings: settings, builder: builder);
      case RouteTransition.slide:
        return _slideRoute(settings: settings, builder: builder);
      case RouteTransition.scale:
        return _scaleRoute(settings: settings, builder: builder);
      case RouteTransition.none:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, _, __) => builder(context),
          transitionDuration: Duration.zero,
        );
      case null:
        return MaterialPageRoute(settings: settings, builder: builder);
    }
  }

  /// Fade transition route
  static Route<dynamic> _fadeRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Slide transition route (from right)
  static Route<dynamic> _slideRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /// Scale transition route
  static Route<dynamic> _scaleRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

        return ScaleTransition(scale: curvedAnimation, child: child);
      },
    );
  }

  /// Error route for undefined routes
  static Route<dynamic> _errorRoute(String routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error'), backgroundColor: Colors.red),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Route Not Found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Route: $routeName',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Go back or navigate to home
                },
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a placeholder page for routes not yet implemented
  static Widget _buildPlaceholderPage({
    required String title,
    String? message,
  }) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'This page is under construction',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Enum for different route transition types
enum RouteTransition { fade, slide, scale, none }
