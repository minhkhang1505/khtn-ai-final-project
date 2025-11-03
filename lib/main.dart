import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/util.dart';
import 'package:khtn_ai_final_project/core/theme/theme.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_generator.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/bots_page.dart';

void main() {
  runApp(const MaterialApp(
    home: BotsPage(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'KHTN AI Final Project',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // Navigation configuration
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
