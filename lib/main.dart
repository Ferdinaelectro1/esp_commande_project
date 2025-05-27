import 'package:esp_commande_project/pages/info_page.dart';
import 'package:esp_commande_project/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:esp_commande_project/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home esp8266 commande',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home esp8266 commande'),
        '/settings_page' : (context) => const SettingsPage(),
        '/info_page' : (context) => const InfoPage()
      },
    );
  }
}



