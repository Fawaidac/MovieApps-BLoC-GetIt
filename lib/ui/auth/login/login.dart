import 'package:flutter/material.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/auth/login/widgets/widget_form_login.dart';
import 'package:getit/utils/extensions.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Lets sign you in",
                    style: AppFonts.poppins(
                      fontSize: 24,
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome back. You've been missed",
                    textAlign: TextAlign.center,
                    style: AppFonts.poppins(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 40),
                  WidgetFormLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
