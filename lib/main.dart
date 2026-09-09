import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manger/core/theme/app_theme.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before app initialization.
  WidgetsFlutterBinding.ensureInitialized();
    runApp(
      ProviderScope(
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Task Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
