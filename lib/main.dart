import 'package:aplicacion_educativa/data/database.dart';
import 'package:aplicacion_educativa/screens/home_screen.dart';
import 'package:aplicacion_educativa/screens/login_screen.dart';
import 'package:aplicacion_educativa/services/session_manager.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appDatabase.ensureDefaultUser();
  await appDatabase.ensureSampleContents();
  await appDatabase.ensureSampleActivityData();
  final savedUsername = await SessionManager.getUsername();
  final savedUser = savedUsername == null
      ? null
      : await appDatabase.getSessionUser(savedUsername);

  runApp(MyApp(initialDisplayName: savedUser?.name));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialDisplayName});

  final String? initialDisplayName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion Educativa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: initialDisplayName == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
