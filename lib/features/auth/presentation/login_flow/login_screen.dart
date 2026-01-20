import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHolder(title: 'Sign In'),
        backgroundColor: SavogueColor.app_bar_color,
      ),
      body: Center(
        child: TextHolder(
          title: 'Login Screen - To be implemented',
          size: 18,
          color: SavogueColor.grey,
        ),
      ),
    );
  }
}
