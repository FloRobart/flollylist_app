import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/data_controller.dart';
import 'controllers/theme_controller.dart';
import 'views/auth/login_page.dart';
import 'views/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authController = AuthController();
  await authController.checkLoginStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authController),
        ChangeNotifierProvider(create: (_) => DataController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final themeController = Provider.of<ThemeController>(context);

    const seed = Colors.red;
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
      useMaterial3: true,
    );
    final darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'FlollyList',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.themeMode,
      home: auth.isAuthenticated ? const HomePage() : const LoginPage(),
    );
  }
}