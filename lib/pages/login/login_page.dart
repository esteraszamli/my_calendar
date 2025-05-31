import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/pages/login/login_page_widgets.dart';
import 'package:my_calendar/theme/responsive_theme.dart';

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

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
    final scale = ResponsiveTheme.scale(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40 * scale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/icon-calendar-app.png',
                    height: 160 * scale),
                WelcomeText(
                  isCreatingAccount: isCreatingAccount,
                ),
                if (isCreatingAccount == false)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * scale),
                    child: Row(
                      children: [
                        Text('Nie masz konta?',
                            style: _textStyle(context, fontSize: 15)),
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
                    padding: EdgeInsets.symmetric(horizontal: 30 * scale),
                    child: Row(
                      children: [
                        Text('Masz już konto?',
                            style: _textStyle(context, fontSize: 15)),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 30 * scale, vertical: 10 * scale),
                  child: EmailField(
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30 * scale, vertical: 10 * scale),
                  child: PasswordField(
                    controller: passwordController,
                  ),
                ),
                if (isCreatingAccount == false)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * scale),
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
                                          style:
                                              _textStyle(context, fontSize: 15),
                                        ),
                                      ),
                                    );
                                  }
                                } catch (error) {
                                  setState(() {
                                    errorMessage =
                                        ErrorHandler.getErrorMessage(error);
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 30 * scale, vertical: 15 * scale),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                      foregroundColor: const Color.fromARGB(255, 63, 204, 222),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20 * scale),
                        side: BorderSide(
                          color: Color.fromARGB(255, 169, 169, 169),
                          width: 1 * scale,
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

                      try {
                        if (isCreatingAccount == true) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } else {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      } catch (error) {
                        setState(() {
                          errorMessage = ErrorHandler.getErrorMessage(error);
                        });
                      }
                    },
                    child: Text(
                      isCreatingAccount == true
                          ? 'Zarejestruj się'
                          : 'Zaloguj się',
                      style: TextStyle(
                        fontSize: 17 * scale,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 63, 204, 222),
                      ),
                    ),
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * scale),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14 * scale),
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
