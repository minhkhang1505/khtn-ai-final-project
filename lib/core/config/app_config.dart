/// Application configuration for different environments
class AppConfig {
  // Change this to switch environments
  static const Environment environment = Environment.production;

  // API URLs based on environment
  static String get authApiUrl {
    switch (environment) {
      case Environment.local:
        return 'http://localhost:8080/api/v1/';
      case Environment.staging:
        return 'https://staging-auth-api.jarvis.cx/api/v1/';
      case Environment.production:
        return 'https://auth-api.jarvis.cx/api/v1/';
    }
  }

  static String get apiUrl {
    switch (environment) {
      case Environment.local:
        return 'http://localhost:8080/api/v1/';
      case Environment.staging:
        return 'https://staging-api.jarvis.cx/api/v1/';
      case Environment.production:
        return 'https://api.jarvis.cx/api/v1/';
    }
  }

  static String get chatApiUrl {
    switch (environment) {
      case Environment.local:
        return 'http://localhost:8080/api/v1/ai-chat/messages';
      case Environment.staging:
        return 'https://staging-api.jarvis.cx/api/v1/ai-chat/messages';
      case Environment.production:
        return 'https://api.jarvis.cx/api/v1/ai-chat/messages';
    }
  }

  static String get knowledgeApiUrl {
    switch (environment) {
      case Environment.local:
        return 'http://localhost:8080/';
      case Environment.staging:
        return 'https://staging-knowledge-api.jarvis.cx/';
      case Environment.production:
        return 'https://knowledge-api.jarvis.cx/';
    }
  }

  static bool get isProduction => environment == Environment.production;
  static bool get isDevelopment =>
      environment == Environment.local || environment == Environment.staging;
}

enum Environment { local, staging, production }
