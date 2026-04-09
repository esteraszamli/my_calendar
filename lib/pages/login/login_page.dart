import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveTheme.scale(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikona aplikacji
              Image.asset(
                'assets/icon/calendar-icon-app.png',
                height: 150 * scale,
              ),

              // Powitanie
              WelcomeText(isCreatingAccount: isCreatingAccount),

              // Przełącznik logowanie/rejestracja
              if (!isCreatingAccount)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nie masz konta?', style: context.textStyle(fontSize: 17)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isCreatingAccount = true;
                        });
                      },
                      child: const Register(),
                    ),
                  ],
                ),
              if (isCreatingAccount)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Masz już konto?', style: context.textStyle(fontSize: 17)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isCreatingAccount = false;
                        });
                      },
                      child: const LogIn(),
                    ),
                  ],
                ),

              // Pola e-mail i hasło
              EmailField(controller: emailController),
              SizedBox(height: 15 * scale),
              PasswordField(controller: passwordController),

              // Przycisk resetu hasła
              if (!isCreatingAccount)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        setState(() {
                          errorMessage = 'Podaj e-mail, aby zresetować hasło';
                        });
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emailController.text,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'E-mail resetujący hasło został wysłany',
                                style: context.textStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }
                      } catch (error) {
                        setState(() {
                          errorMessage = ErrorHandler.getErrorMessage(error);
                        });
                      }
                    },
                    child: const ForgetPassword(),
                  ),
                ),

              SizedBox(height: 20 * scale),

              // Przycisk logowania/rejestracji
Center(
  child: SizedBox(
    width: 200 * scale, 
    height: 50 * scale, 
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ResponsiveTheme.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30 * scale),
        ),
      ),
      onPressed: () async {
        setState(() {
          errorMessage = '';
        });

        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          setState(() {
            errorMessage = 'Uzupełnij wszystkie pola';
          });
          return;
        }

        try {
          if (isCreatingAccount) {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
          } else {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
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
        isCreatingAccount ? 'Zarejestruj się' : 'Zaloguj się',
        style: TextStyle(fontSize: 18 * scale, fontWeight: FontWeight.w500),
      ),
    ),
  ),
),

              // Wyświetlenie błędów
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10 * scale),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: const Color.fromARGB(255, 208, 76, 63), fontSize: 16 * scale),
                  ),
                ),
                SizedBox(height: 80 * scale) 
            ],
          ),
        ),
      ),
    );
  }
}