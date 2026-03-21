import 'package:aplicacion_educativa/screens/content/content_list_screen.dart';
import 'package:aplicacion_educativa/screens/login_screen.dart';
import 'package:aplicacion_educativa/screens/news/news_list_screen.dart';
import 'package:aplicacion_educativa/services/session_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openNews(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NewsListScreen(),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SessionManager.clearSession();

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendizaje'),
        actions: [
          IconButton(
            onPressed: () => _openNews(context),
            tooltip: 'Noticias',
            icon: const Icon(Icons.campaign_outlined),
          ),
          IconButton(
            onPressed: () => _logout(context),
            tooltip: 'Cerrar sesion',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ContentListView(),
    );
  }
}
