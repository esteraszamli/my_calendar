import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_calendar/app/my_app.dart';
import 'package:my_calendar/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Ustawienie trybu wyświetlania na pełny ekran (edge-to-edge)
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  
  // Ustawienie przezroczystego paska nawigacji systemowej
  // Używamy SystemUiOverlayStyle z kontrastem dla ikon
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      // Navigation bar
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      // Dla Android 15+ - wymuszenie kontrastu
      systemNavigationBarContrastEnforced: false,
    ),
  );
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}
