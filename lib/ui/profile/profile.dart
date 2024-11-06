import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:getit/data/model/user.dart';
import 'package:getit/services/cubit/auth_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/custom_textfield.dart';
import 'package:getit/utils/extensions.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.getDataUser();

    if (user != null) {
      nameController.text = user.username;
      emailController.text = user.email;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: darkColor,
              child: Icon(
                Icons.keyboard_arrow_left,
                color: whiteColor,
              ),
            ),
          ),
        ),
        title: Text(
          "Your Profile",
          style: AppFonts.poppins(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<AuthCubit, User?>(
          builder: (context, state) {
            if (state == null) {
              return const Center(child: Text('No user data available.'));
            }
            return Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("images/killua.jpg"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  state.username,
                  style: AppFonts.poppins(
                      fontSize: 18,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  state.email,
                  style: AppFonts.poppins(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: FontWeight.w300),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  width: deviceSize.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                    border: Border.all(
                      color: whiteColor,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Name",
                        icon: Icons.person,
                        controller: nameController,
                      ),
                      const Gap(15),
                      CustomTextField(
                        hintText: "Email",
                        icon: Icons.mail,
                        controller: emailController,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        height: 48,
                        width: deviceSize.width,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().updateUserData(
                                nameController.text, emailController.text);
                            Fluttertoast.showToast(msg: "Profile Updated");
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
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
                            "Save",
                            style: AppFonts.poppins(
                              fontSize: 16,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 48,
                        width: deviceSize.width,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                            Navigator.pushReplacementNamed(context, '/login');
                            Fluttertoast.showToast(msg: "Logout Successfully");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
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
                            "LogOut",
                            style: AppFonts.poppins(
                              fontSize: 16,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
