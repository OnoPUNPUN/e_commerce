import 'package:e_commerce/features/auth/data/login_request_model.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/shared/presentation/screen/bottom_navbar_screen.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:email_validator/email_validator.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../shared/presentation/widgets/show_snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in-screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    AppLogo(width: 100),
                    const SizedBox(height: 24),
                    Text("Welcome Back", style: textTheme.headlineLarge),
                    Text(
                      "Please Enter Your Email Address",
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: const InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length <= 4) {
                          return 'Password must be more than 4 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<LoginController>(
                      builder: (_) {
                        return Visibility(
                          visible: _loginController.logInProgress == false,
                          replacement: CenterCicularProgress(),
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _onTapLoginButton();
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not a member?", style: textTheme.bodyMedium),
                        GestureDetector(
                          onTap: _onTapSignUpButton,
                          child: const Text(
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
      ),
    );
  }

  void _onTapLoginButton() {
    _signIn();
  }

  Future<void> _signIn() async {
    LoginRequestModel requestModel = LoginRequestModel(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
    bool isSuccess = await _loginController.login(requestModel);

    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
        _loginController.userModel!,
        _loginController.accessToken!,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottomNavbarScreen.name,
            (predicate) => false,
      );
    } else {
      showSnackbarMessage(context, _loginController.errorMessage!);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
