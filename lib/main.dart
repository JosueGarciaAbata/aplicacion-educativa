import 'package:aplicacion_educativa/screens/home_screen.dart';
import 'package:aplicacion_educativa/screens/login_screen.dart';
import 'package:aplicacion_educativa/services/session_manager.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedUsername = await SessionManager.getUsername();

  runApp(MyApp(initialUsername: savedUsername));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialUsername});

  final String? initialUsername;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion Educativa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: initialUsername == null
          ? const LoginScreen()
          : HomeScreen(username: initialUsername!),
    );
  }
}
