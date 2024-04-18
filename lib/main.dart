// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:harry_potter_characters/di/services_locator.dart';
import 'package:harry_potter_characters/services/character_services.dart';
import 'package:harry_potter_characters/ui/character_screen.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Harry Potter Characters',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CharactersScreen(),
      ),
    );
  }
}
