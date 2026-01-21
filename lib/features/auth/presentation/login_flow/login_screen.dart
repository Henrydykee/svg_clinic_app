import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:savouge/features/navbar/navbar.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_field.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/data/color_utils.dart';
import '../../../../core/managers/biometric_manager.dart';
import '../create_account/create_account_screen.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleBiometricLogin() async {
    try {
      final biometricManager = BioMetricManager();
      await biometricManager.checkAvailableBiometrics();
      final authenticated = await biometricManager.authenticateUser();
      
      if (authenticated) {
        // TODO: Handle biometric login success
        print('Biometric authentication successful');
      }
    } catch (e) {
      print('Biometric authentication error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Sign in',
        showBackIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(32),
                        TextHolder(
                          title: 'Welcome Back',
                          size: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        Gap(8),
                        TextHolder(
                          title: 'Sign in to your account to continue',
                          size: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                        Gap(32),
                        CustomTextField(
                          title: 'Email address',
                          hinttitle: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        Gap(20),
                        CustomTextField(
                          title: 'Password',
                          hinttitle: 'Enter your password',
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                    
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Gap(12),
                        GestureDetector(
                          onTap: () {
                            router.push(const ForgotPasswordScreen());
                          },
                          child: TextHolder(
                            title: 'Forgot Password?',
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: "#C5A35E".toColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(
                    children: [
                      CustomButtom(
                        title: 'Sign In',
                        btnColor: "#C5A35E".toColor(),
                        textColor: Colors.white,
                        onTap: () {
                          router.push( Navbar());
                          // if (_formKey.currentState?.validate() ?? false) {
                          //   // TODO: Implement login logic
                          // }
                        },
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHolder(
                            title: 'Don\'t have an account? ',
                            color: Colors.grey.shade600,
                            size: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              router.push(const CreateAccountScreen());
                            },
                            child: TextHolder(
                              title: 'Create',
                              color: "#C5A35E".toColor(),
                              fontWeight: FontWeight.bold,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      Gap(32),
                      GestureDetector(
                        onTap: _handleBiometricLogin,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/images/biomeric_icon.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
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
