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
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordChangeVisible = false;
  String errorMessage = '';

  String _getErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'wrong-password':
        return 'Nieprawidłowe aktualne hasło';
      case 'weak-password':
        return 'Hasło jest za słabe. Powinno mieć min. 6 znaków';
      default:
        return 'Wystąpił błąd zmiany hasła';
    }
  }

  Future<void> _changePassword() async {
    setState(() {
      errorMessage = '';
    });
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Uzupełnij wszystkie pola';
      });
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        errorMessage = 'Nowe hasła nie są identyczne';
      });
      return;
    }
    if (_newPasswordController.text.length < 6) {
      setState(() {
        errorMessage = 'Nowe hasło musi mieć minimum 6 znaków';
      });
      return;
    }
    if (_newPasswordController.text.length > 30) {
      setState(() {
        errorMessage = 'Nowe hasło może mieć maksymalnie 30 znaków';
      });
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
      _confirmPasswordController.clear();
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
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = _getErrorMessage(e);
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Wystąpił nieznany błąd: ${error.toString()}';
      });
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
            if (!_isPasswordChangeVisible) ...[
              Icon(
                Icons.person,
                size: 60,
                color: Color.fromARGB(255, 99, 222, 231).withOpacity(0.8),
              ),
              const SizedBox(height: 25),
              Text(
                'Zalogowano jako: ${user?.email ?? 'Brak emaila'}',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
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
            ],
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
              ),
            ),
            if (_isPasswordChangeVisible) ...[
              const SizedBox(height: 10),
              SizedBox(
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
              SizedBox(
                width: 300,
                child: TextField(
                  style: GoogleFonts.outfit(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Potwierdź nowe hasło',
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
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
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
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
