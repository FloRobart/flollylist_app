import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/data_controller.dart';
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

    return MaterialApp(
      title: 'FlollyList',
      theme: ThemeData(
        primarySwatch: Colors.red, // Thème Noël
        useMaterial3: true,
      ),
      home: auth.isAuthenticated ? const HomePage() : const LoginPage(),
    );
  }
}