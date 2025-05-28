import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordChange extends StatelessWidget {
  const PasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Potwierdź zmianę hasła',
      style: GoogleFonts.outfit(
        fontSize: 16,
        color: Color.fromARGB(255, 48, 166, 188),
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
    return Text(
      _isPasswordChangeVisible ? 'Anuluj zmianę hasła' : 'Zmień hasło',
      style: GoogleFonts.outfit(
        fontSize: 16,
        color: Color.fromARGB(255, 48, 166, 188),
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
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red, fontSize: 14),
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
    return SizedBox(
      width: 300,
      child: TextField(
        style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w500),
        controller: _confirmPasswordController,
        decoration: InputDecoration(
          labelText: 'Potwierdź nowe hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 48, 166, 188),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 48, 166, 188),
              width: 2.0,
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
    return SizedBox(
      width: 300,
      child: TextField(
        style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w500),
        controller: _newPasswordController,
        decoration: InputDecoration(
          labelText: 'Nowe hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 48, 166, 188),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 48, 166, 188),
              width: 2.0,
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
    return SizedBox(
      width: 300,
      child: TextField(
        controller: _currentPasswordController,
        decoration: InputDecoration(
          labelText: 'Aktualne hasło',
          labelStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 48, 166, 188),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 48, 166, 188),
              width: 2.0,
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
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        foregroundColor: Color.fromARGB(255, 63, 204, 222),
      ),
      child: Text(
        'Wyloguj się',
        style: GoogleFonts.outfit(
          fontSize: 17,
          color: Color.fromARGB(255, 39, 206, 225),
          fontWeight: FontWeight.w500,
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
    return Text(
      'Zalogowano jako: ${user?.email ?? 'Brak emaila'}',
      style: GoogleFonts.outfit(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class PersonIcon extends StatelessWidget {
  const PersonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 60,
      color: Color.fromARGB(255, 143, 239, 246),
    );
  }
}
