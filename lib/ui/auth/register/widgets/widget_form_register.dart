import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:getit/services/cubit/auth_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/extensions.dart';
import 'package:getit/utils/custom_textfield.dart';

class WidgetFormRegister extends StatelessWidget {
  const WidgetFormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confPasswordController =
        TextEditingController();

    String? validateName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Name is required';
      }
      return null;
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Email format must be valid';
      }
      return null;
    }

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 6) {
        return 'Password must be more than 6 characters';
      }
      return null;
    }

    String? validateConfPassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Confirm password is required';
      }
      if (value.length < 6) {
        return 'Password must be more than 6 characters';
      }
      if (value != confPasswordController.text) {
        return 'Passwords must match';
      }
      return null;
    }

    void register() async {
      final username = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final success =
          await context.read<AuthCubit>().register(username, email, password);
      if (success) {
        Navigator.pushReplacementNamed(context, '/login');
        Fluttertoast.showToast(msg: "Registered Successfully");
      } else {
        Fluttertoast.showToast(msg: "Registration failed. Try again.");
      }
    }

    final deviceSize = context.deviceSize;

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Name",
            icon: Icons.person,
            controller: nameController,
            validator: validateName,
          ),
          const Gap(15),
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
          const Gap(15),
          CustomTextField(
            hintText: "Confirm Password",
            icon: Icons.lock,
            isObs: true,
            controller: confPasswordController,
            validator: validateConfPassword,
          ),
          const Gap(30),
          SizedBox(
            height: 48,
            width: deviceSize.width,
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    register();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "Register",
                  style: AppFonts.poppins(
                      fontSize: 16,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          const Gap(50),
          Text(
            "Copyright@2024",
            style: AppFonts.poppins(
                fontSize: 12, color: whiteColor, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
