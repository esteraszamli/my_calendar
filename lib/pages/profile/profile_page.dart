import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/pages/profile/profile_page_widgets.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

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
              style: _textStyle(context,
                  fontSize: 15, fontWeight: FontWeight.w400),
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

  TextStyle _textStyle(
    BuildContext context, {
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    final scale = ResponsiveTheme.scale(context);
    return GoogleFonts.outfit(
      fontSize: fontSize * scale,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final scale = ResponsiveTheme.scale(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isPasswordChangeVisible) ...[
              PersonIcon(),
              SizedBox(height: 25 * scale),
              UserLogin(user: user),
              SizedBox(height: 25 * scale),
              LogOutButton(),
            ],
            SizedBox(height: 10 * scale),
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
              SizedBox(height: 10 * scale),
              CurrentPassword(
                  currentPasswordController: _currentPasswordController),
              SizedBox(height: 16 * scale),
              NewPassword(newPasswordController: _newPasswordController),
              SizedBox(height: 16 * scale),
              ConfirmPassword(
                  confirmPasswordController: _confirmPasswordController),
              SizedBox(height: 16 * scale),
              ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 248, 248, 248),
                  foregroundColor: Color.fromARGB(255, 63, 204, 222),
                ),
                child: PasswordChange(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30 * scale, vertical: 10 * scale),
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
