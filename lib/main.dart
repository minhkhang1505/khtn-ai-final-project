import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/util.dart';
import 'package:khtn_ai_final_project/theme/theme.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_generator.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/agents_page.dart';

void main() {
  //runApp(const MyApp());
  runApp(const MaterialApp(
    home: AgentsPage(),
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
