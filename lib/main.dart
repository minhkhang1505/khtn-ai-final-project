import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/auth_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/prompt_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/user_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/repositories/auth_repository_implement.dart';
import 'package:khtn_ai_final_project/data/repositories/prompt_repository_implement.dart';
import 'package:khtn_ai_final_project/data/repositories/user_repository_implement.dart';
import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';
import 'package:khtn_ai_final_project/domain/usecases/get_user_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/login_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/logout_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/sign_up_usecase.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth_view_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/theme/util.dart';
import 'package:khtn_ai_final_project/core/theme/theme.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_generator.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Tầng Data Source (API)
  final authApiClient = AuthApiClient();
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSourceImpl(
    authApiClient,
  );
  final AuthLocalDataSource localDataSource = AuthLocalDataSourceImpl();
  final PromptRemoteDataSource promptRemoteDataSource =
      PromptRemoteDataSourceImpl(await JarvisApiClient.create());

  // Initialize UserApiClient with GUID support
  final userApiClient = await JarvisApiClient.create();
  final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSourceImpl(
    userApiClient,
  );

  // 2️⃣ Tầng Repository
  final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  final PromptRepositoryImpl promptRepository = PromptRepositoryImpl(
    promptRemoteDataSource,
  );

  final userRepository = UserRepositoryImpl(userRemoteDataSource);

  // 3️⃣ Tầng UseCase
  final signUpUseCase = SignUpUseCase(repository: authRepository);
  final loginUseCase = LoginUsecase(authRepository: authRepository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(
            signUpUseCase: signUpUseCase,
            loginUsecase: loginUseCase,
            logoutUsecase: LogoutUsecase(authRepository: authRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(
            getUserUseCase: GetUserUseCase(userRepository: userRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PromptViewmodel(
            getPromptUseCase: GetPromptUseCase(promptRepository),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch ThemeProvider for theme changes
    final themeProvider = context.watch<ThemeProvider>();

    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'KHTN AI Final Project',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeProvider.themeMode,
      // Navigation configuration
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
