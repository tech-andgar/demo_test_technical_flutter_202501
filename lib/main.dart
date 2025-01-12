//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  runApp(
    const ProviderScope(
      overrides: [],
      child: InitialApp(),
    ),
  );
}

class InitialApp extends ConsumerStatefulWidget {
  const InitialApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitialAppState();
}

class _InitialAppState extends ConsumerState<InitialApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeService(context, ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const MyApp();
        }
      },
    );
  }

  Future<void> _initializeService([BuildContext? _, WidgetRef? __]) async {
    log('Inicializar servicios ...');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Demo Test Technical 202501 - Andres Garcia',
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      routerDelegate: AppRoutes.router.routerDelegate,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
