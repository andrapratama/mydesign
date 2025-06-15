import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mydesign/my_app/cubit/focus_cubit.dart';
import 'package:mydesign/my_app/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isEmailValid = false;
  bool obscurePassword = true;

  void validateEmail(String email) {
    setState(() {
      isEmailValid = email.contains('@') && email.contains('.');
    });
  }

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        context.read<FocusCubit>().focusOn("email");
      } else {
        context.read<FocusCubit>().clearFocus();
      }
    });

    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        context.read<FocusCubit>().focusOn("password");
      } else {
        context.read<FocusCubit>().clearFocus();
      }
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusCubit, String?>(
      builder: (context, focusedField) {
        return Scaffold(
          backgroundColor: Colors.blue[45],
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "MY",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "APP",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: const Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 28, color: Colors.blueGrey),
                    ),
                  ),
                  Center(
                    child: const Text(
                      "Sign in to your account",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildAnimatedTextField(
                    focusNode: _emailFocus,
                    hintText: 'Email',
                    iconData: Icons.email,
                    isFocused: focusedField == 'email',
                  ),
                  const SizedBox(height: 10),
                  _buildAnimatedTextField(
                    focusNode: _passwordFocus,
                    hintText: 'Password',
                    iconData: Icons.lock,
                    isFocused: focusedField == 'password',
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      const Text("Or sign in with"),
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 12), // Jarak antara ikon dan teks
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 12), // Jarak antara ikon dan teks
                          Text(
                            "Continue with Apple",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTextField({
    required FocusNode focusNode,
    required String hintText,
    required IconData iconData,
    required bool isFocused,
    bool obscureText = false,
  }) {
    Color targetColor = isFocused ? Colors.green : Colors.grey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: targetColor, width: isFocused ? 1.5 : 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          TweenAnimationBuilder<Color?>(
            tween: ColorTween(begin: Colors.grey, end: targetColor),
            duration: const Duration(milliseconds: 300),
            builder: (context, color, child) {
              return Icon(iconData, color: color);
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
