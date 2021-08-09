import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/theme.dart';
import 'features/home/presentation/pages/home.dart';
import 'injection.dart';

void main() {
  configureDependencies();
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
