import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          isCreatingAccount == true
                              ? 'Rejestracja'
                              : 'Logowanie',
                          style: const TextStyle(fontSize: 23),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCreatingAccount == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        const Text('Nie masz konta?'),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = true;
                            });
                          },
                          child: const Text(
                            'Zarejestruj się',
                            style: TextStyle(
                                color: Color.fromARGB(255, 39, 206, 225)),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isCreatingAccount == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        const Text('Masz już konto?'),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = false;
                            });
                          },
                          child: const Text(
                            'Zaloguj się',
                            style: TextStyle(
                                color: Color.fromARGB(255, 39, 206, 225)),
                          ),
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
                        child: TextField(
                          controller: widget.emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
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
                        child: TextField(
                          obscureText: true,
                          controller: widget.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Hasło',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
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
                                        ),
                                      ),
                                    );
                                  }
                                } catch (error) {
                                  setState(() {
                                    errorMessage =
                                        'Wystąpił błąd: ${error.toString()}';
                                  });
                                }
                              },
                              child: const Text(
                                'Nie pamiętam hasła',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 39, 206, 225),
                                  fontSize: 14,
                                ),
                              ),
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
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 169, 169, 169),
                                  width: 1),
                            ),
                          ),
                          onPressed: () async {
                            if (isCreatingAccount == true) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                );
                              } catch (error) {
                                setState(() {
                                  errorMessage = error.toString();
                                });
                              }
                            } else {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                );
                              } catch (error) {
                                setState(() {
                                  errorMessage = error.toString();
                                });
                              }
                            }
                          },
                          child: Text(
                            isCreatingAccount == true
                                ? 'Zarejestruj się'
                                : 'Zaloguj się',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 39, 206, 225),
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
