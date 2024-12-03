import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Zalogowano jako:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Wyloguj się',
                  style: TextStyle(
                      color: Color.fromARGB(255, 39, 206, 225), fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
