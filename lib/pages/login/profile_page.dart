import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _newPasswordController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  bool _isPasswordChangeVisible = false;

  Future<void> _changePassword() async {
    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Hasło musi mieć minimum 6 znaków',
          style: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        )),
      );
      return;
    }

    if (_newPasswordController.text.length > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Hasło może mieć maksymalnie 30 znaków',
          style: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        )),
      );
      return;
    }
    try {
      final user = FirebaseAuth.instance.currentUser;

      final credential = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: _currentPasswordController.text,
      );

      await user?.reauthenticateWithCredential(credential);

      await user?.updatePassword(_newPasswordController.text);

      _newPasswordController.clear();
      _currentPasswordController.clear();
      setState(() {
        _isPasswordChangeVisible = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Hasło zostało zmienione',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          )),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Błąd: ${e.message}',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zalogowano jako: ${user?.email ?? 'Brak emaila'}',
              style: GoogleFonts.outfit(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text(
                'Wyloguj się',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  color: Color.fromARGB(255, 39, 206, 225),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  setState(() {
                    _isPasswordChangeVisible = !_isPasswordChangeVisible;
                  });
                },
                child: Text(
                  _isPasswordChangeVisible
                      ? 'Anuluj zmianę hasła'
                      : 'Zmień hasło',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Color.fromARGB(255, 37, 151, 164),
                    fontWeight: FontWeight.w500,
                  ),
                )),
            if (_isPasswordChangeVisible) ...[
              const SizedBox(height: 10),
              SizedBox(
                // ??? czcionka nie działa
                width: 300,
                child: TextField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Aktualne hasło',
                    labelStyle: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  style: GoogleFonts.outfit(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Nowe hasło',
                    labelStyle: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _changePassword,
                  child: Text(
                    'Potwierdź zmianę hasła',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Color.fromARGB(255, 37, 151, 164),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }
}
