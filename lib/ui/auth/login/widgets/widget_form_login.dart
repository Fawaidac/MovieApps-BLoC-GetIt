import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/auth/register/register.dart';
import 'package:getit/utils/extensions.dart';
import 'package:getit/widgets/customtextfield.dart';

class WidgetFormLogin extends StatelessWidget {
  const WidgetFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email tidak boleh kosong';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Masukkan email yang valid';
      }
      return null;
    }

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password tidak boleh kosong';
      }
      if (value.length < 6) {
        return 'Password harus lebih dari 6 karakter';
      }
      return null;
    }

    final deviceSize = context.deviceSize;

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Email",
            icon: Icons.mail,
            controller: emailController,
            validator: validateEmail,
          ),
          const Gap(15),
          CustomTextField(
            hintText: "Password",
            icon: Icons.lock,
            isObs: true,
            controller: passwordController,
            validator: validatePassword,
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.transparent,
              ),
              child: Text(
                "Login",
                style: AppFonts.poppins(
                  fontSize: 16,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: whiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "OR",
                    style: AppFonts.poppins(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 48,
            width: deviceSize.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: whiteColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Register",
                style: AppFonts.poppins(
                  fontSize: 16,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Gap(50),
          Text(
            "Copyright@2024",
            style: AppFonts.poppins(
              fontSize: 12,
              color: whiteColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
