import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/pages/profile/profile_page_widgets.dart';

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
            backgroundColor: Color.fromARGB(255, 107, 215, 152),
          ),
        );
      }
    } catch (error) {
      setState(() {
        errorMessage = ErrorHandler.getErrorMessage(error);
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
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 63, 204, 222),
              ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 248, 248, 248),
                  foregroundColor: Color.fromARGB(255, 63, 204, 222),
                ),
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
