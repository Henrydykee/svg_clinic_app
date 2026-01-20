import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:savouge/features/auth/presentation/create_account/verify_email_screen.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_field.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/platform/color.dart';
import '../../../../core/utils/data/color_utils.dart';
import '../login_flow/login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  String? _selectedBranch;
  
  final List<String> _branches = [
    'Savouge Manila',
    'Savouge Quezon City',
    'Savouge BGC',
    'Savouge Cebu',
    'Savouge Davao',
    'Savouge Pampanga',
  ];
  
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Create Account',
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
                      Gap(24),
                      TextHolder(
                        title: 'Create Account',
                        size: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      Gap(8),
                      TextHolder(
                        title: 'Join our beauty community today.',
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      Gap(32),
                      CustomTextField(
                        title: 'Full Name',
                        hinttitle: 'Enter your full name',
                        controller: _fullNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      Gap(20),
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
                        title: 'Phone Number',
                        hinttitle: 'Enter your phone number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        prefixText: '+63 🇵🇭',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHolder(
                            title: 'Preferred Branch',
                            color: newprojectColor.grey_2,
                            size: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          DropdownButtonFormField<String>(
                            value: _selectedBranch,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10, right: 10),
                              hintText: 'Select your preferred branch',
                              fillColor: Color(0xFFF3F5F7),
                              filled: true,
                              hintStyle: TextStyle(fontFamily: 'Sora'),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            style: TextStyle(
                              color: newprojectColor.grey_2,
                              fontSize: 14,
                              fontFamily: 'Sora',
                            ),
                            icon: SizedBox.shrink(),
                            items: _branches.map((String branch) {
                              return DropdownMenuItem<String>(
                                value: branch,
                                child: Text(branch),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBranch = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a branch';
                              }
                              return null;
                            },
                          ),
                        ],
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
                      Gap(24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value ?? false;
                              });
                            },
                            activeColor: "#C5A35E".toColor(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _agreeToTerms = !_agreeToTerms;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Sora',
                                      color: Colors.grey.shade700,
                                    ),
                                    children: [
                                      TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        style: TextStyle(
                                          color: "#C5A35E".toColor(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: "#C5A35E".toColor(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(24),
                      CustomButtom(
                      title: 'Create Account',
                      btnColor: "#C5A35E".toColor(),
                      textColor: Colors.white,
                      onTap: () {
                        // if (_formKey.currentState?.validate() ?? false) {
                        //   if (!_agreeToTerms) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: TextHolder(
                        //           title: 'Please agree to the Terms & Conditions',
                        //           color: Colors.white,
                        //         ),
                        //         backgroundColor: Colors.red,
                        //       ),
                        //     );
                        //     return;
                        //   }
                        //   // Handle account creation
                        // }
                        router.push(const VerifyEmailScreen(email: 'test@test.com',));
                      },
                    ),
                    Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextHolder(
                          title: 'Already have an account? ',
                          color: Colors.grey.shade600,
                          size: 15,
                        ),
                        TextHolder(
                          title: 'Sign in',
                          color: "#C5A35E".toColor(),
                          fontWeight: FontWeight.bold,
                          size: 15,
                          onTap: () => router.push(const LoginScreen()),
                        ),
                      ],
                    ),
                    ],
                  ),
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
