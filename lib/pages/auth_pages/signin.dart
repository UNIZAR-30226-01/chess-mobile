/// Page that allows the user to sign in.
import 'package:flutter/material.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/communications/api.dart';
import '../menus_pages/bottom_bar.dart';
import '../../components/buttons/return.dart';
import '../../components/buttons/text_long.dart';
import '../../components/popups/pop_error.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  // Method to update username
  void updateUsername(userText) {
    setState(() {
      username = userText;
    });
  }

  // Method to update password
  void updatePassword(pwText) {
    setState(() {
      password = pwText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Form(
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Return button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReturnButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Welcome text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      '¡Bienvenido! ¡Me alegra verte de nuevo!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Username textfield
                  TextFieldCustom(
                    labelText: 'Nombre de usuario',
                    obscureText: false,
                    iconText: Icons.person,
                    onChanged: (userTxt) => updateUsername(userTxt),
                    validator: (userTxt) => userTxt == null || userTxt.isEmpty
                        ? 'Introduce un nombre de usuario válido'
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Password textfield
                  TextFieldCustom(
                    labelText: 'Contraseña',
                    obscureText: true,
                    iconText: Icons.lock,
                    onChanged: (passTxt) => updatePassword(passTxt),
                    validator: (passTxt) {
                      if (passTxt == null || passTxt.isEmpty) {
                        return 'Introduce una contraseña válida';
                      } else if (passTxt.length < 8) {
                        return 'La contraseña debe tener al menos 8 carácteres';
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPwPage(),
                              ),
                            );
                          },
                          child: const Text(
                            '¿Contraseña olvidada?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 115, 117, 121),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  // Login button
                  textButton(
                    context,
                    true,
                    'Acceder',
                    () async {
                      final isValidForm = formKey.currentState!.validate();

                      // No errors in textfields
                      if (isValidForm) {
                        int errCode = await apiSignIn(
                          username,
                          password,
                        );

                        switch (errCode) {
                          // Credentials are correct
                          case 0:
                            // "Mala práctica"
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomBar.fromSignIn(),
                                ),
                              );
                            }
                            break;

                          // An error has occurred during authentication
                          default:
                            if (context.mounted) {
                              popupERR(context,
                                  "Ha ocurrido un error durante la autenticación");
                            }
                        }
                      }
                    },
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // Sign Up option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // User doesn't have an account
                      const Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(
                        width: 5,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: Text(
                          '¡Regístrate ahora!',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              // Color.fromARGB(255, 59, 203, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
