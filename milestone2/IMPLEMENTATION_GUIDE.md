# Milestone 2: Implementation Guidelines & Architecture

## 📚 Quick Reference

### Feature Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    MILESTONE 2 SCOPE                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. AUTHENTICATION & AUTHORIZATION (7 issues)              │
│     ├── Login/Register with validation                     │
│     ├── Email verification & password reset                │
│     ├── Social auth (Google)                               │
│     ├── Session management & logout                        │
│     └── Error handling & retry logic                       │
│                                                             │
│  2. AI CHAT (9 issues)                                      │
│     ├── Message sending/receiving                          │
│     ├── Message history & pagination                       │
│     ├── Bot selection & switching                          │
│     ├── Conversation management                            │
│     ├── Message search                                     │
│     ├── Offline support                                    │
│     └── Error handling & recovery                          │
│                                                             │
│  3. PROMPT MANAGEMENT (12 issues)                           │
│     ├── Create/Read/Update/Delete                          │
│     ├── Search & filtering                                 │
│     ├── Categories management                              │
│     ├── Favorites/save prompts                             │
│     ├── Usage tracking & analytics                         │
│     ├── Sharing & visibility control                       │
│     └── Integration with chat                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🏗️ Architecture Implementation Details

### Layer Structure for Each Feature

For each feature (Auth, Chat, Prompt), follow this structure:

```
lib/
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── auth_remote_data_source.dart
│   │   │   ├── chat_remote_data_source.dart
│   │   │   └── prompt_remote_data_source.dart
│   │   └── local/
│   │       ├── auth_local_data_source.dart
│   │       ├── chat_local_data_source.dart
│   │       └── prompt_local_data_source.dart
│   │
│   ├── models/
│   │   ├── auth_model.dart (extends existing models)
│   │   ├── chat_message_model.dart
│   │   ├── conversation_model.dart
│   │   └── prompt_model.dart (extends existing)
│   │
│   └── repositories/
│       ├── auth_repository_impl.dart
│       ├── chat_repository_impl.dart
│       └── prompt_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── user_entity.dart
│   │   ├── message_entity.dart
│   │   ├── conversation_entity.dart
│   │   └── prompt_entity.dart (may exist)
│   │
│   ├── repositories/
│   │   ├── auth_repository.dart (interface)
│   │   ├── chat_repository.dart (interface)
│   │   └── prompt_repository.dart (interface)
│   │
│   └── usecases/
│       ├── auth/
│       │   ├── login_usecase.dart
│       │   ├── register_usecase.dart
│       │   ├── logout_usecase.dart
│       │   └── ...
│       ├── chat/
│       │   ├── send_message_usecase.dart
│       │   ├── get_messages_usecase.dart
│       │   └── ...
│       └── prompts/
│           ├── create_prompt_usecase.dart
│           ├── get_prompts_usecase.dart
│           └── ...
│
└── presentation/
    ├── viewmodels/
    │   ├── auth_view_model.dart
    │   ├── chat_view_model.dart
    │   └── prompt_view_model.dart
    │
    └── views/
        ├── auth/ (already exists)
        ├── chat/ (needs enhancement)
        └── prompts/ (already exists)
```

---

## 📋 API Endpoints Required

### Base Configuration

```dart
// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = 'https://your-api.com/api/v1';
  static const String authBaseUrl = '$baseUrl/auth';
  static const String chatBaseUrl = '$baseUrl/chat';
  static const String promptsBaseUrl = '$baseUrl/prompts';
}
```

### Authentication Endpoints

```
POST   /auth/register
  - Body: { email, password, fullName, ... }
  - Response: { accessToken, refreshToken, user }

POST   /auth/login
  - Body: { email, password }
  - Response: { accessToken, refreshToken, user }

POST   /auth/refresh-token
  - Body: { refreshToken }
  - Response: { accessToken, refreshToken }

POST   /auth/logout
  - Headers: { Authorization: Bearer token }
  - Response: { success }

POST   /auth/forgot-password
  - Body: { email }
  - Response: { message }

POST   /auth/verify-email
  - Body: { email, otp }
  - Response: { success }

POST   /auth/reset-password
  - Body: { email, otp, newPassword }
  - Response: { success }

POST   /auth/google
  - Body: { googleToken }
  - Response: { accessToken, refreshToken, user }
```

### Chat Endpoints

```
GET    /chat/conversations
  - Query: { page, limit, botId }
  - Response: { conversations: [], total, page, limit }

POST   /chat/conversations
  - Body: { botId, title }
  - Response: { id, botId, title, createdAt }

GET    /chat/conversations/{id}/messages
  - Query: { page, limit }
  - Response: { messages: [], total, page, limit }

POST   /chat/conversations/{id}/messages
  - Body: { content, promptId? }
  - Response: { id, content, sender, timestamp }

DELETE /chat/conversations/{id}
  - Response: { success }

GET    /chat/bots
  - Response: { bots: [{ id, name, description, ... }] }

GET    /chat/conversations/{id}
  - Response: { id, botId, title, messages[], ... }
```

### Prompt Endpoints

```
GET    /prompts
  - Query: { page, limit, categoryId?, search?, sort? }
  - Response: { prompts: [], total, page, limit }

POST   /prompts
  - Body: { title, content, categoryId, tags, isPublic }
  - Response: { id, title, content, ... }

GET    /prompts/{id}
  - Response: { id, title, content, stats, ... }

PUT    /prompts/{id}
  - Body: { title?, content?, categoryId?, tags?, isPublic? }
  - Response: { id, title, content, ... }

DELETE /prompts/{id}
  - Response: { success }

GET    /prompts/categories
  - Response: { categories: [{ id, name, count }] }

GET    /prompts/search
  - Query: { q, categoryId?, tags? }
  - Response: { prompts: [] }

POST   /prompts/{id}/favorite
  - Response: { success }

DELETE /prompts/{id}/favorite
  - Response: { success }

GET    /prompts/{id}/stats
  - Response: { usageCount, lastUsed, trends: [] }

GET    /prompts/shared-with-me
  - Query: { page, limit }
  - Response: { prompts: [] }

POST   /prompts/{id}/share
  - Body: { userId | email, permission }
  - Response: { success }
```

---

## 🔐 Security Implementation

### Token Management

```dart
// lib/presentation/services/token_service.dart
class TokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _secureStorage;

  // Store tokens securely
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Retrieve tokens
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  // Token refresh logic
  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = await getAccessToken();
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveTokens(data['accessToken'], data['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
```

### HTTP Interceptor

```dart
// lib/presentation/services/api_service.dart
class ApiService {
  final http.Client client;
  final TokenService tokenService;

  // Add token to all requests
  Future<Map<String, String>> _getHeaders() async {
    final token = await tokenService.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // GET request with auto-refresh
  Future<http.Response> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 401) {
        // Token expired, try refresh
        final refreshed = await tokenService.refreshAccessToken();
        if (refreshed) {
          return get(endpoint); // Retry
        }
        // Logout user
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Similar for POST, PUT, DELETE...
}
```

---

## 📦 State Management Patterns

### ViewModel Pattern with Provider

```dart
// lib/presentation/viewmodels/auth_view_model.dart
class AuthViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  // State variables
  bool _isLoading = false;
  String? _error;
  User? _user;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  // Methods
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _loginUseCase(LoginParams(email, password));

    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (user) {
        _user = user;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _logoutUseCase();
    _user = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
```

### Usage in View

```dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              if (viewModel.error != null)
                ErrorWidget(message: viewModel.error!),
              LoginForm(
                onSubmit: (email, password) {
                  viewModel.login(email, password);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
```

---

## 🔄 Error Handling Pattern

### Error Classes

```dart
// lib/core/errors/failure.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  ServerFailure(String message, {this.statusCode}) : super(message);
}
```

### Repository Implementation with Error Handling

```dart
// lib/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      // Validate input
      if (!_isValidEmail(email)) {
        return Left(ValidationFailure('Invalid email format'));
      }

      // Check connectivity
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return Left(NetworkFailure('No internet connection'));
      }

      // Make API call
      final user = await remoteDataSource.login(email, password);

      // Cache locally
      await localDataSource.cacheUser(user);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unknown error occurred'));
    }
  }
}
```

---

## 🧪 Testing Strategy

### Unit Test Example

```dart
// test/domain/usecases/login_usecase_test.dart
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testUser = User(id: 1, email: testEmail);

    test('should return User when login succeeds', () async {
      // Arrange
      when(mockAuthRepository.login(testEmail, testPassword))
          .thenAnswer((_) async => Right(testUser));

      // Act
      final result = await loginUseCase(
        LoginParams(testEmail, testPassword),
      );

      // Assert
      expect(result, Right(testUser));
      verify(mockAuthRepository.login(testEmail, testPassword));
    });
  });
}
```

### Widget Test Example

```dart
// test/presentation/views/auth/login/login_page_test.dart
void main() {
  group('LoginPage', () {
    testWidgets('should display login form', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthViewModel>(
              create: (_) => MockAuthViewModel(),
            ),
          ],
          child: MaterialApp(home: LoginPage()),
        ),
      );

      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
```

---

## 📱 UI Component Guidelines

### Authentication UI

- Use existing widgets in `presentation/common/widgets/auth_*`
- Maintain consistent styling with theme
- Show loading indicators during API calls
- Display validation errors inline
- Use secure text field for passwords

### Chat UI

- Use `flutter_chat_bubble` for message display
- Implement smooth scrolling to latest message
- Show typing indicators for bot responses
- Use pull-to-refresh for message history
- Display offline indicator when needed

### Prompt UI

- Use list view with pagination
- Show loading states for each item
- Implement smooth transitions between screens
- Use consistent card design
- Show metadata (category, tags, usage count)

---

## 🚀 Performance Optimization

### Data Caching

```dart
// Implement for all remote data sources
class PromptRemoteDataSource {
  final http.Client client;
  final SharedPreferences prefs;

  static const String _cacheKeyPrefix = 'prompts_cache_';
  static const Duration _cacheDuration = Duration(minutes: 30);

  Future<List<PromptModel>> getPrompts(int page) async {
    // Try cache first
    final cached = _getCachedPrompts(page);
    if (cached != null && !_isCacheExpired(page)) {
      return cached;
    }

    // Fetch from API
    final response = await client.get(...);
    final prompts = _parsePrompts(response);

    // Cache for later
    await _cachePrompts(page, prompts);

    return prompts;
  }

  void _cachePrompts(int page, List<PromptModel> prompts) {
    prefs.setString(
      '$_cacheKeyPrefix$page',
      jsonEncode(prompts.map((p) => p.toJson()).toList()),
    );
    prefs.setInt('${_cacheKeyPrefix}time_$page', DateTime.now().millisecondsSinceEpoch);
  }
}
```

### Pagination Implementation

```dart
// Always load data in pages to reduce memory usage
const int _pageSize = 20;

class PromptViewModel extends ChangeNotifier {
  List<Prompt> _prompts = [];
  int _currentPage = 1;
  bool _hasMorePages = true;
  bool _isLoadingMore = false;

  Future<void> loadMorePrompts() async {
    if (_isLoadingMore || !_hasMorePages) return;

    _isLoadingMore = true;
    notifyListeners();

    final newPrompts = await _getPromptsUseCase(
      GetPromptsParams(page: _currentPage, limit: _pageSize),
    );

    _prompts.addAll(newPrompts);
    _currentPage++;
    _hasMorePages = newPrompts.length == _pageSize;
    _isLoadingMore = false;
    notifyListeners();
  }
}
```

---

## 🔄 Dependency Injection Setup

### Service Locator Configuration

```dart
// lib/core/di/service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // External dependencies
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Data sources - Auth
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<http.Client>()),
  );
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );

  // Use cases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt<AuthRepository>()),
  );

  // ViewModels
  getIt.registerSingleton<AuthViewModel>(
    AuthViewModel(
      getIt<LoginUseCase>(),
      getIt<RegisterUseCase>(),
      getIt<LogoutUseCase>(),
    ),
  );
}
```

---

## ✨ Best Practices Checklist

- [ ] Follow clean architecture principles
- [ ] Separate concerns across layers
- [ ] Use Either types for error handling
- [ ] Implement proper logging
- [ ] Cache data appropriately
- [ ] Handle network errors gracefully
- [ ] Implement retry logic for failed requests
- [ ] Use secure storage for sensitive data
- [ ] Add comprehensive error messages
- [ ] Implement offline support where needed
- [ ] Test all business logic
- [ ] Follow Dart style guide
- [ ] Document complex logic
- [ ] Use consistent naming conventions
- [ ] Implement loading states properly
- [ ] Add success/error notifications
- [ ] Optimize for performance
- [ ] Ensure responsive UI
- [ ] Support both iOS and Android
- [ ] Implement proper lifecycle management

---

## 📚 Additional Resources

- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Dartz Either Pattern](https://pub.dev/packages/dartz)
- [HTTP Interceptors Pattern](https://medium.com/flutter-community/handling-rest-api-in-flutter)
- [Testing in Flutter](https://flutter.dev/docs/testing)
