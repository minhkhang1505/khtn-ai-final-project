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
  static const String main = '/main'; // Main page with bottom navigation

  // Auth routes (example - can be extended)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String resetPassword = '/auth/reset-password';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verificationEmail = '/auth/register/verification-email';

  // Profile routes (example - can be extended)
  static const String settings = '/settings';
  static const String aiEmail = '/account/ai_email';

  // Feature routes (example - can be extended)
  static const String details = '/details';

  /// Create New Prompt
  static const String prompts = '/prompts';
  static const String createNewPrompt = '/prompts/new';
  static const String promptDetails = '/prompts/details';

  /// New Knowledge Source
  static const String newKnowledgeSource = '/knowledge/new';
  static const String knowledgeDetails = '/knowledge/details';

  /// Bots routes
  static const String bots = '/bots';
  static const String createNewBot = '/bots/new';
  static const String editBot = '/bots/edit';

  /// Agents routes
  static const String agents = '/agents';
  static const String createNewAgent = '/agents/new';
  static const String editAgent = '/agents/edit';
  static const String agentChat = '/agents/chat';

  /// Get all route names as a list
  /// Useful for debugging or logging
  static List<String> get allRoutes => [
    splash,
    main,
    login,
    register,
    forgotPassword,
    settings,
    details,
    createNewPrompt,
    promptDetails,
    bots,
    createNewBot,
    editBot,
    agents,
    createNewAgent,
    editAgent,
    agentChat,
  ];
}
