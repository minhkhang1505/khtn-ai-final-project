import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth_view_model.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_form.dart';
import 'package:provider/provider.dart';

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

  void _handleSignIn() async {
    final viewModel = context.read<AuthViewModel>();

    final success = await viewModel.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      Navigator.pushNamed(context, '/main');
      return;
    } else {
      final error = viewModel.error ?? "Login failed";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void _handleGoogleSignIn() {
    Navigator.pushNamed(context, '/main');
    // TODO: Implement Google sign in logic
  }

  void _handleForgotPassword() {
    Navigator.pushNamed(context, '/auth/forgot-password');
    // TODO: Implement forgot password logic
  }

  void _handleSignUp() {
    Navigator.pushNamed(context, '/auth/register');
    // TODO: Navigate to sign up page
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 600;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 500 : double.infinity,
                ),
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
          },
        ),
      ),
    );
  }
}
