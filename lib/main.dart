import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/provider.dart';
import 'routes/routers.dart';
import 'utils/app_theme.dart';
import 'utils/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Set preferred orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Hive
  await initHive();

  // Run app with Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

/// Global navigator key
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialRoute = ref.watch(initialRouteProvider);

    return MaterialApp(
      title: 'Shanti Patra Dealer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      routes: Routers.routes,
      initialRoute: initialRoute,
      navigatorKey: navigatorKey,
    );
  }
}
