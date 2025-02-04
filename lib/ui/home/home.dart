import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/ui/home/movie/popular_movie.dart';
import 'package:getit/ui/home/movie/top_rated_movie.dart';
import 'package:getit/ui/home/movie/upcoming_movie.dart';
import 'package:getit/ui/home/widgets/widget_top_home.dart';

import '../../themes/fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const WidgetTopHome(),
            Gap(15),
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.search,
                      color: whiteColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    label: Text(
                      "Search",
                      style: AppFonts.poppins(fontSize: 12, color: whiteColor),
                    ))),
            TopRatedMovie(),
            PopularMovie(),
            UpcomingMovie(),
          ],
        ),
      )),
    );
  }
}
