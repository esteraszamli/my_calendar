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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                isCreatingAccount == true ? 'Rejestracja' : 'Logowanie',
                style: const TextStyle(fontSize: 23),
              ),
            ),
            const SizedBox(height: 5),
            if (isCreatingAccount == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 39, 206, 225)),
                      ),
                    ),
                  ],
                ),
              ),
            if (isCreatingAccount == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        style:
                            TextStyle(color: Color.fromARGB(255, 39, 206, 225)),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 340,
                child: TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 340,
                child: TextField(
                  obscureText: true,
                  controller: widget.passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Hasło',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (isCreatingAccount == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      if (widget.emailController.text.isEmpty) {
                        // Wyświetl komunikat, jeśli e-mail nie jest podany
                        setState(() {
                          errorMessage = 'Podaj e-mail, aby zresetować hasło';
                        });
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: widget.emailController.text,
                        );
                        // Pokaż SnackBar z potwierdzeniem wysłania e-maila
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
                        // Obsługa błędów (np. niepoprawny e-mail)
                        setState(() {
                          errorMessage = 'Wystąpił błąd: ${error.toString()}';
                        });
                      }
                    },
                    child: const Text('Nie pamiętam hasła',
                        style: TextStyle(
                            color: Color.fromARGB(255, 39, 206, 225))),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 340,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 169, 169, 169), width: 1),
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
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
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
            ),
            const SizedBox(height: 15),
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
    );
  }
}
