import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/pages/login/login_page_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  var errorMessage = '';
  var isCreatingAccount = false;

  // Cache dla Google Fonts
  late final TextStyle outfitRegular;
  late final TextStyle outfitMedium;
  late final TextStyle outfitLarge;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    outfitRegular =
        GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w400);
    outfitMedium =
        GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500);
    outfitLarge = GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w400);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                WelcomeText(
                  isCreatingAccount: isCreatingAccount,
                  textStyle: outfitLarge,
                ),
                if (isCreatingAccount == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('Nie masz konta?', style: outfitRegular),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = true;
                            });
                          },
                          child: Register(textStyle: outfitMedium),
                        ),
                      ],
                    ),
                  ),
                if (isCreatingAccount == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('Masz już konto?', style: outfitRegular),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = false;
                            });
                          },
                          child: LogIn(textStyle: outfitMedium),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: EmailField(
                    controller: emailController,
                    textStyle: outfitMedium,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: PasswordField(
                    controller: passwordController,
                    textStyle: outfitMedium,
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
                                if (emailController.text.isEmpty) {
                                  setState(() {
                                    errorMessage =
                                        'Podaj e-mail, aby zresetować hasło';
                                  });
                                  return;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                    email: emailController.text,
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'E-mail resetujący hasło został wysłany na ${emailController.text}',
                                          style: outfitRegular,
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
                              child: ForgetPassword(textStyle: outfitRegular),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                      foregroundColor: const Color.fromARGB(255, 63, 204, 222),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 169, 169, 169),
                          width: 1,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        errorMessage = '';
                      });

                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        setState(() {
                          errorMessage = 'Uzupełnij wszystkie pola';
                        });
                        return;
                      }

                      if (isCreatingAccount == true) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
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
                            email: emailController.text,
                            password: passwordController.text,
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
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
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
