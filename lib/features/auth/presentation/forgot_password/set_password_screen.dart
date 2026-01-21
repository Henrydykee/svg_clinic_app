import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_field.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/data/color_utils.dart';
import '../login_flow/login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Forgot password',
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
                          title: 'Set up password',
                          size: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        Gap(8),
                        TextHolder(
                          title: 'Choose your unique sign in password',
                          size: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                        Gap(32),
                        CustomTextField(
                          title: 'Password',
                          hinttitle: 'Enter your password',
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          prefix: Icon(
                            Icons.lock_outline,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
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
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Gap(20),
                        CustomTextField(
                          title: 'Confirm password',
                          hinttitle: 'Confirm your password',
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          prefix: Icon(
                            Icons.lock_outline,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          suffix: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey.shade600,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
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
                        title: 'Proceed',
                        btnColor: "#C5A35E".toColor(),
                        textColor: Colors.white,
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // TODO: Implement password reset logic
                            // Navigate to success screen or login screen
                          }
                        },
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHolder(
                            title: 'Didn\'t forget password? ',
                            color: Colors.grey.shade600,
                            size: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              router.push(const LoginScreen());
                            },
                            child: TextHolder(
                              title: 'Sign In',
                              color: "#C5A35E".toColor(),
                              fontWeight: FontWeight.bold,
                              size: 15,
                            ),
                          ),
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
