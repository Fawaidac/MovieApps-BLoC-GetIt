import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getit/services/cubit/auth_cubit.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authCubit = GetIt.I<AuthCubit>();

    await Future.delayed(const Duration(seconds: 3));

    if (authCubit.state != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'FlickNite.',
                  style: AppFonts.montserrat(
                    fontSize: 20,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your Ultimate Movie Companion",
                  style: AppFonts.poppins(
                    fontSize: 12,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
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
