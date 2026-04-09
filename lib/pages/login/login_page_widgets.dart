import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    required this.isCreatingAccount,
  });

  final bool isCreatingAccount;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 30 * scale, vertical: 15 * scale),
      child: Text(
        isCreatingAccount ? 'Witaj!' : 'Witaj ponownie!',
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
            fontSize: 28 * scale, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Nie pamiętam hasła',
      style: GoogleFonts.outfit(
        fontSize: 17 * scale,
        fontWeight: FontWeight.w500,
        color: ResponsiveTheme.primaryColor,
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return TextField(
      style:
          GoogleFonts.outfit(fontSize: 17 * scale, fontWeight: FontWeight.w400),
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Hasło',
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 15 * scale),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ResponsiveTheme.accentColor,
            width: 2.0 * scale,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: ResponsiveTheme.primaryColor,
            size: 24 * scale,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return TextField(
      style:
          GoogleFonts.outfit(fontSize: 17 * scale, fontWeight: FontWeight.w400),
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 15 * scale),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ResponsiveTheme.accentColor,
            width: 2.0 * scale,
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Zaloguj się',
      style: GoogleFonts.outfit(
        fontSize: 17 * scale,
        fontWeight: FontWeight.w500,
        color: ResponsiveTheme.accentColor,
      ),
    );
  }
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Text(
      'Zarejestruj się',
      style: GoogleFonts.outfit(
        fontSize: 17 * scale,
        fontWeight: FontWeight.w500,
        color: ResponsiveTheme.accentColor,
      ),
    );
  }
}
