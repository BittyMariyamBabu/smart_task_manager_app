import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manger/core/router/app_router.dart';
import 'package:smart_task_manger/core/theme/app_theme.dart';
import 'package:smart_task_manger/firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before app initialization.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase before using Firebase services
  // and uses the configuration for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
    runApp(
      ProviderScope(
      child: const MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Smart Task Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // home: const LoginPage(),
    );
  }
}
