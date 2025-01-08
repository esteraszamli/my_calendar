import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/pages/login/login_page.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    required this.isCreatingAccount,
  });

  final bool isCreatingAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isCreatingAccount == true ? 'Witaj!' : 'Witaj ponownie!',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nie pamiętam hasła',
      style: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 39, 206, 225)),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.widget,
  });

  final LoginPage widget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500),
      obscureText: true,
      controller: widget.passwordController,
      decoration: InputDecoration(
        hintText: 'Hasło',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.widget,
  });

  final LoginPage widget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500),
      controller: widget.emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Zaloguj się',
      style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 39, 206, 225)),
    );
  }
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Zarejestruj się',
      style: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 39, 206, 225)),
    );
  }
}
