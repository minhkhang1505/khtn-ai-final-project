import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                SvgPicture.asset(
                  "assets/icons/ic_ai_star.svg",
                  width: 60,
                  height: 60,
                  colorFilter: const ColorFilter.mode(
                    Colors.lightBlue,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                Text("Sign in to continue to your AI workspace"),
                SizedBox(height: 30),
                Container(
                  height: 480,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Text description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text("Enter your credentials to access your account"),
                        ],
                      ),
                      //Email field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Enter your email',
                            ),
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                      //Password field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Enter your password',
                            ),
                            onChanged: (value) {},
                            obscureText: true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              // Checkbox(value: value, onChanged: onChanged),
                              Text("Remember me"),
                            ],
                          ),
                          //Forgot password?
                          Text("Forgot password?"),
                        ],
                      ),
                      //Sign button
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/ic_arrow_right.svg",
                        ),
                        label: Text("Sign In"),
                      ),
                      //------- or continue with --------
                      Row(
                        children: [
                          Expanded(flex: 1, child: Divider()),
                          Text("  Or continue with  "),
                          Expanded(flex: 1, child: Divider()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          // Gooogle
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/ic_google.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text("Google"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          // Github
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/ic_google.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text("Github"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Do not have account?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(width: 4),
                          Text("Sign up"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}