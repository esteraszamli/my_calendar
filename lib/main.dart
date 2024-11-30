import 'package:flutter/material.dart';
import 'package:my_calendar/pages/calendar/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 192, 192, 192)),
        useMaterial3: true,
      ),
      home: const CalendarPage(),
    );
  }
}
