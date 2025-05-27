import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    required this.isCreatingAccount,
    required this.textStyle,
  });

  final bool isCreatingAccount;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        isCreatingAccount ? 'Witaj!' : 'Witaj ponownie!',
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nie pamiętam hasła',
      style: textStyle.copyWith(
        color: const Color.fromARGB(255, 39, 206, 225),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.textStyle,
  });

  final TextEditingController controller;
  final TextStyle textStyle;

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.textStyle,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Hasło',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 48, 166, 188),
            width: 2.0,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color.fromARGB(255, 39, 206, 225),
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
    required this.textStyle,
  });

  final TextEditingController controller;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textStyle,
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 48, 166, 188),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Zaloguj się',
      style: textStyle.copyWith(
        color: const Color.fromARGB(255, 39, 206, 225),
      ),
    );
  }
}

class Register extends StatelessWidget {
  const Register({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Zarejestruj się',
      style: textStyle.copyWith(
        color: const Color.fromARGB(255, 39, 206, 225),
      ),
    );
  }
}
