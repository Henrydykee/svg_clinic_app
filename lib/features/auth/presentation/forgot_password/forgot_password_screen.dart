import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_field.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/data/color_utils.dart';
import '../login_flow/login_screen.dart';
import 'verify_password_email_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                          title: 'Forgot password?',
                          size: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        Gap(8),
                        TextHolder(
                          title: 'No worries, enter the email address linked to your Savouge account',
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
                            // Navigate to verify password email screen
                            router.push(VerifyPasswordEmailScreen(
                              email: _emailController.text,
                            ));
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
