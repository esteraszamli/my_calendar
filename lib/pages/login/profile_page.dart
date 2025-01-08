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
              _Person(),
              const SizedBox(height: 25),
              _UserLogin(user: user),
              const SizedBox(height: 25),
              _LogOutButton(),
            ],
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _isPasswordChangeVisible = !_isPasswordChangeVisible;
                });
              },
              child: _PasswordButton(
                  isPasswordChangeVisible: _isPasswordChangeVisible),
            ),
            if (_isPasswordChangeVisible) ...[
              const SizedBox(height: 10),
              _CurrentPassword(
                  currentPasswordController: _currentPasswordController),
              const SizedBox(height: 16),
              _NewPassword(newPasswordController: _newPasswordController),
              const SizedBox(height: 16),
              _ConfirmPassword(
                  confirmPasswordController: _confirmPasswordController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _changePassword,
                child: _PasswordChange(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _ErrorMessage(errorMessage: errorMessage),
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

class _PasswordChange extends StatelessWidget {
  const _PasswordChange();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Potwierdź zmianę hasła',
      style: GoogleFonts.outfit(
        fontSize: 16,
        color: Color.fromARGB(255, 37, 151, 164),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _PasswordButton extends StatelessWidget {
  const _PasswordButton({
    required bool isPasswordChangeVisible,
  }) : _isPasswordChangeVisible = isPasswordChangeVisible;

  final bool _isPasswordChangeVisible;

  @override
  Widget build(BuildContext context) {
    return Text(
      _isPasswordChangeVisible ? 'Anuluj zmianę hasła' : 'Zmień hasło',
      style: GoogleFonts.outfit(
        fontSize: 16,
        color: Color.fromARGB(255, 37, 151, 164),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({
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

class _ConfirmPassword extends StatelessWidget {
  const _ConfirmPassword({
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
        ),
        obscureText: true,
      ),
    );
  }
}

class _NewPassword extends StatelessWidget {
  const _NewPassword({
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
        ),
        obscureText: true,
      ),
    );
  }
}

class _CurrentPassword extends StatelessWidget {
  const _CurrentPassword({
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
        ),
        obscureText: true,
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}

class _UserLogin extends StatelessWidget {
  const _UserLogin({
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

class _Person extends StatelessWidget {
  const _Person();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 60,
      color: Color.fromARGB(255, 99, 222, 231).withValues(
        alpha: 35,
      ),
    );
  }
}
