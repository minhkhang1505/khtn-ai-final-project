import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_generator.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KHTN AI Final Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      // Navigation configuration
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
