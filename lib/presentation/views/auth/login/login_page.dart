import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth/auth_view_model.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_form.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';

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

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _handleSignIn() async {
    if (!await _checkInternetConnection()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Please check your network.'),
        ),
      );
      return;
    }

    final viewModel = sl<AuthViewModel>();
    final success = await viewModel.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      Navigator.pushNamed(context, '/main');
      return;
    }
  }

  // void _handleGoogleSignIn() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Google sign in is not implemented yet.")),
  //   );
  //   // TODO: Implement Google sign in logic
  // }

  void _handleForgotPassword() {
    Navigator.pushNamed(context, '/auth/forgot-password');
  }

  void _handleSignUp() {
    Navigator.pushNamed(context, '/auth/register');
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
                          // onGoogleSignIn: _handleGoogleSignIn,
                          onSignUpTap: _handleSignUp,
                          loginError: sl<AuthViewModel>(),
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
