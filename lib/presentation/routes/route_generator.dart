import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/forgot_password/forgot_password.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/reset_password/reset_password.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/register/verifiaction_email/verification_email.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/knowledge_detail_screen.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/newknowledgesource/new_knowledge.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/create_new_prompt.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/promptdetail/prompt_detail_page.dart';
import 'package:khtn_ai_final_project/presentation/views/splash/splash_page.dart';
import 'package:khtn_ai_final_project/presentation/views/home/home_page.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/login_page.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/register/register.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/create_prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_detail_view_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/udpate_prompt_usecase.dart';

import 'package:khtn_ai_final_project/presentation/views/agents/agents_page.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/create_agent_page.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/edit_agent_page.dart';

import 'package:khtn_ai_final_project/presentation/views/bots/bots_page.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/create_bot_page.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/edit_bot_page.dart';

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

      case AppRoutes.main:
        return _buildRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );

      case AppRoutes.verificationEmail:
        final email = args is Map<String, dynamic>
            ? args['email'] as String?
            : null;
        return _buildRoute(
          builder: (_) =>
              VerificationEmailPage(email: email ?? 'john@example.com'),
          settings: settings,
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
          builder: (_) => const LoginPage(), // 👈 Changed to actual LoginPage
        );

      case AppRoutes.register:
        return _buildRoute(
          settings: settings,
          builder: (_) => const RegisterPage(),
        );

      case AppRoutes.forgotPassword:
        return _buildRoute(
          settings: settings,
          builder: (_) => ForgotPasswordPage(),
        );

      case AppRoutes.resetPassword:
        return _buildRoute(
          settings: settings,
          builder: (_) => ResetPasswordPage(),
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

      case AppRoutes.createNewPrompt:
        return _buildRoute(
          settings: settings,
          builder: (context) {
            final promptViewModel = Provider.of<PromptViewmodel>(
              context,
              listen: false,
            );
            return ChangeNotifierProvider(
              create: (_) => CreatePromptViewModel(
                createPromptUseCase: promptViewModel.createPromptUseCase,
              ),
              child: const CreateNewPromptPage(),
            );
          },
        );

      case AppRoutes.promptDetails:
        final prompt = settings.arguments as PromptEntity?;
        if (prompt == null || prompt.id.isEmpty) {
          debugPrint('Khang - Error: prompt is null or prompt.id is empty');
          return _errorRoute('promptDetails - Missing prompt');
        }
        debugPrint(
          'Khang - Route received prompt: ${prompt.id} - ${prompt.title}',
        );
        return _buildRoute(
          settings: settings,
          builder: (context) {
            final promptViewModel = Provider.of<PromptViewmodel>(
              context,
              listen: false,
            );
            return ChangeNotifierProvider(
              create: (_) => PromptDetailViewModel(
                getPromptUseCase: promptViewModel.getPromptUseCase,
                updatePromptUseCase: UpdatePromptUsecase(
                  repository: promptViewModel.deletePromptUseCase.repository,
                ),
                deletePromptUseCase: promptViewModel.deletePromptUseCase,
                prompt: prompt,
              )..loadPromptDetails(),
              child: const PromptDetailPage(),
            );
          },
        );

      case AppRoutes.newKnowledgeSource:
        return _buildRoute(
          settings: settings,
          builder: (_) => const NewKnowledgeScreen(),
        );

      case AppRoutes.knowledgeDetails:
        return _buildRoute(
          settings: settings,
          builder: (_) => KnowledgeDetailScreen(),
        );

      case AppRoutes.agents:
        return _buildRoute(
          settings: settings,
          builder: (_) => const AgentsPage(),
        );

      case AppRoutes.createNewAgent:
        return _buildRoute(
          settings: settings,
          builder: (_) => const CreateAgentPage(),
        );

      case AppRoutes.editAgent:
        final editAgent = args is Map<String, dynamic> ? args['agent'] : args;
        return _buildRoute(
          settings: settings,
          builder: (_) => EditAgentPage(agent: editAgent),
        );

      case AppRoutes.bots:
        return _buildRoute(
          settings: settings,
          builder: (_) => const BotsPage(),
        );

      case AppRoutes.createNewBot:
        return _buildRoute(
          settings: settings,
          builder: (_) => const CreateBotPage(),
        );

      case AppRoutes.editBot:
        final editBot = args is Map<String, dynamic> ? args['bot'] : args;
        return _buildRoute(
          settings: settings,
          builder: (_) => EditBotPage(bot: editBot),
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
