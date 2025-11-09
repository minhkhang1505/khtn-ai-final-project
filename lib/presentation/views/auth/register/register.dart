import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool? _isTermsChecked = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    Navigator.pushNamed(context, '/auth/register/verification-email');
    // TODO: Implement create account logic
  }

  void _handleGoogleSignUp() {
    Navigator.pushNamed(context, '/main');
    // TODO: Implement Google sign up logic
  }

  void _handleSignIn() {
    Navigator.pushNamed(context, '/auth/login');
    // TODO: Navigate to sign in page
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 500 : double.infinity,
              ),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AuthHeader(
                          title: "Create Account",
                          subtitle: "Join thousands of AI enthusiasts today!",
                        ),
                        RegisterForm(
                          fullNameController: _fullNameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          isTermsChecked: _isTermsChecked,
                          onTermsChanged: (value) {
                            setState(() {
                              _isTermsChecked = value;
                            });
                          },
                          onCreateAccount: _handleCreateAccount,
                          onGoogleSignUp: _handleGoogleSignUp,
                          onSignInTap: _handleSignIn,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
