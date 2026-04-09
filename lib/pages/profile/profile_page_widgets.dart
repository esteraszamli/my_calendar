import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

class PasswordChange extends StatelessWidget {
  const PasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Potwierdź zmianę hasła',
      style: GoogleFonts.outfit(
        fontSize: 16 * scale,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class PasswordButton extends StatelessWidget {
  const PasswordButton({
    super.key,
    required bool isPasswordChangeVisible,
  }) : _isPasswordChangeVisible = isPasswordChangeVisible;

  final bool _isPasswordChangeVisible;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      _isPasswordChangeVisible ? 'Anuluj zmianę hasła' : 'Zmień hasło',
      style: GoogleFonts.outfit(
        fontSize: 17 * scale,
        color: ResponsiveTheme.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      errorMessage,
      style: TextStyle(
        color: const Color.fromARGB(255, 208, 76, 63),
        fontSize: 14 * scale,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({
    super.key,
    required TextEditingController confirmPasswordController,
  }) : _confirmPasswordController = confirmPasswordController;

  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return SizedBox(
      width: 300 * scale,
      child: TextField(
        style: GoogleFonts.outfit(
            fontSize: 16 * scale, fontWeight: FontWeight.w500),
        controller: _confirmPasswordController,
        decoration: InputDecoration(
          labelText: 'Potwierdź nowe hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
            color: ResponsiveTheme.primaryColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ResponsiveTheme.accentColor,
              width: 2.0 * scale,
            ),
          ),
        ),
        obscureText: true,
      ),
    );
  }
}

class NewPassword extends StatelessWidget {
  const NewPassword({
    super.key,
    required TextEditingController newPasswordController,
  }) : _newPasswordController = newPasswordController;

  final TextEditingController _newPasswordController;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return SizedBox(
      width: 300 * scale,
      child: TextField(
        style: GoogleFonts.outfit(
            fontSize: 16 * scale, fontWeight: FontWeight.w500),
        controller: _newPasswordController,
        decoration: InputDecoration(
          labelText: 'Nowe hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
            color: ResponsiveTheme.primaryColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ResponsiveTheme.accentColor,
              width: 2.0 * scale,
            ),
          ),
        ),
        obscureText: true,
      ),
    );
  }
}

class CurrentPassword extends StatelessWidget {
  const CurrentPassword({
    super.key,
    required TextEditingController currentPasswordController,
  }) : _currentPasswordController = currentPasswordController;

  final TextEditingController _currentPasswordController;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return SizedBox(
      width: 300 * scale,
      child: TextField(
        style: GoogleFonts.outfit(
            fontSize: 16 * scale, fontWeight: FontWeight.w500),
        controller: _currentPasswordController,
        decoration: InputDecoration(
          labelText: 'Aktualne hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w400,
            color: ResponsiveTheme.primaryColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ResponsiveTheme.accentColor,
              width: 2.0 * scale,
            ),
          ),
        ),
        obscureText: true,
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return SizedBox(
      width: 170 * scale,
      height: 45 * scale, 
      child: ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ResponsiveTheme.primaryColor,
          foregroundColor: ResponsiveTheme.primaryColor,
        ),
        child: Text(
          'Wyloguj się',
          style: GoogleFonts.outfit(
            fontSize: 18 * scale,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class UserLogin extends StatelessWidget {
  const UserLogin({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      '${user?.email ?? 'Brak emaila'}',
      style: GoogleFonts.outfit(
        fontSize: 18 * scale,
        fontWeight: FontWeight.w500,
        color: ResponsiveTheme.accentColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class PersonIcon extends StatelessWidget {
  const PersonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Icon(
      Icons.person,
      size: 60 * scale,
      color: ResponsiveTheme.primaryColor,
    );
  }
}