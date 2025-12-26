import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/core/theme/util.dart';
import 'package:khtn_ai_final_project/core/theme/theme.dart';

import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_generator.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/theme_provider.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    // Get ThemeProvider from GetIt and listen to changes
    _themeProvider = sl<ThemeProvider>()
      ..addListener(() {
        setState(() {}); // Rebuild when theme changes
      });
  }

  @override
  void dispose() {
    _themeProvider.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'KHTN AI Final Project',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: _themeProvider.themeMode,
      // Navigation configuration
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [routeObserver],
    );
  }
}
