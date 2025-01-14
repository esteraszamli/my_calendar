import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/pages/login/profile_page_widgets.dart';

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
              PersonIcon(),
              const SizedBox(height: 25),
              UserLogin(user: user),
              const SizedBox(height: 25),
              LogOutButton(),
            ],
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _isPasswordChangeVisible = !_isPasswordChangeVisible;
                });
              },
              child: PasswordButton(
                  isPasswordChangeVisible: _isPasswordChangeVisible),
            ),
            if (_isPasswordChangeVisible) ...[
              const SizedBox(height: 10),
              CurrentPassword(
                  currentPasswordController: _currentPasswordController),
              const SizedBox(height: 16),
              NewPassword(newPasswordController: _newPasswordController),
              const SizedBox(height: 16),
              ConfirmPassword(
                  confirmPasswordController: _confirmPasswordController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _changePassword,
                child: PasswordChange(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ErrorMessage(errorMessage: errorMessage),
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
