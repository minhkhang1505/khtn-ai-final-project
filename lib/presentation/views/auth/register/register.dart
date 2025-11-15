import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth_view_model.dart';
import '../widgets/auth_header.dart';
import 'widgets/register_form.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
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

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _handleCreateAccount() async {

    if (!await _checkInternetConnection()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Please check your network.'),
        ),
      );
      return; 
    }

    final viewModel = context.read<AuthViewModel>();
    final success = await viewModel.signUp(
      _emailController.text,
      _passwordController.text,
      _confirmPasswordController.text,
      _fullNameController.text,
    );
    if (success) {
      Navigator.pushNamed(context, '/main');
    } else {
      final error = viewModel.error ?? "Sign-up failed";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void _handleGoogleSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Google sign up is not implemented yet.")),
    );
    // TODO: Implement Google sign up logic
  }

  void _handleSignIn() {
    Navigator.pushNamed(context, '/auth/login');
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
                          error: context.watch<AuthViewModel>(),
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
