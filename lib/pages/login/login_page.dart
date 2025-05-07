import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/pages/login/login_page_widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  String _getErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Nieprawidłowy format emaila';
      case 'user-not-found':
        return 'Użytkownik nie istnieje';
      case 'wrong-password':
        return 'Nieprawidłowe hasło';
      case 'invalid-credential':
        return 'Nieprawidłowy email lub hasło';
      case 'email-already-in-use':
        return 'Konto z tym emailem już istnieje';
      case 'weak-password':
        return 'Hasło jest za słabe. Powinno mieć min. 6 znaków';
      default:
        return 'Wystąpił błąd logowania';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/icon-calendar-app.png', height: 160),
                WelcomeText(isCreatingAccount: isCreatingAccount),
                if (isCreatingAccount == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Nie masz konta?',
                          style: GoogleFonts.outfit(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = true;
                            });
                          },
                          child: Register(),
                        ),
                      ],
                    ),
                  ),
                if (isCreatingAccount == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('Masz już konto?',
                            style: GoogleFonts.outfit(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = false;
                            });
                          },
                          child: LogIn(),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: EmailField(widget: widget),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: PasswordField(widget: widget),
                      ),
                    ],
                  ),
                ),
                if (isCreatingAccount == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                if (widget.emailController.text.isEmpty) {
                                  setState(() {
                                    errorMessage =
                                        'Podaj e-mail, aby zresetować hasło';
                                  });
                                  return;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                    email: widget.emailController.text,
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'E-mail resetujący hasło został wysłany na ${widget.emailController.text}',
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (error) {
                                  setState(() {
                                    errorMessage = _getErrorMessage(error);
                                  });
                                } catch (error) {
                                  setState(() {
                                    errorMessage =
                                        'Wystąpił błąd: ${error.toString()}';
                                  });
                                }
                              },
                              child: ForgetPassword(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 251, 251, 251),
                            foregroundColor: Color.fromARGB(255, 63, 204, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 169, 169, 169),
                                  width: 1),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              errorMessage = '';
                            });

                            if (widget.emailController.text.isEmpty ||
                                widget.passwordController.text.isEmpty) {
                              setState(() {
                                errorMessage = 'Uzupełnij wszystkie pola';
                              });
                              return;
                            }

                            if (isCreatingAccount == true) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                );
                              } on FirebaseAuthException catch (error) {
                                setState(() {
                                  errorMessage = _getErrorMessage(error);
                                });
                              }
                            } else {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                );
                              } on FirebaseAuthException catch (error) {
                                setState(() {
                                  errorMessage = _getErrorMessage(error);
                                });
                              }
                            }
                          },
                          child: Text(
                            isCreatingAccount == true
                                ? 'Zarejestruj się'
                                : 'Zaloguj się',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 63, 204, 222),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          errorMessage,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
