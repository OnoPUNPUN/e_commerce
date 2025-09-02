import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  AppLogo(width: 80),
                  const SizedBox(height: 24),
                  Text("Complete Your Profile", style: textTheme.headlineLarge),
                  Text(
                    "Get started with us with your details",
                    style: textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "First Name"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "Last Name"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "Email Address"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: "Address"),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapLoginButton,
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?", style: textTheme.bodyMedium),
                      GestureDetector(
                        onTap: _onTapSignUpButton,
                        child: Text(
                          " Sign Up Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
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

  void _onTapLoginButton() {}

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
