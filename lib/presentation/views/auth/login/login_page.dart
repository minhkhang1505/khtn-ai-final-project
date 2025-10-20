import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMeChecked = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    // TODO: Implement sign in logic
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google sign in logic
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password logic
  }

  void _handleSignUp() {
    // TODO: Navigate to sign up page
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(
                  title: "Welcome",
                  subtitle: "Sign in to continue to your AI workspace",
                ),
                LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isRememberMeChecked: _isRememberMeChecked,
                  onRememberMeChanged: (value) {
                    setState(() {
                      _isRememberMeChecked = value;
                    });
                  },
                  onForgotPassword: _handleForgotPassword,
                  onSignIn: _handleSignIn,
                  onGoogleSignIn: _handleGoogleSignIn,
                  onSignUpTap: _handleSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
