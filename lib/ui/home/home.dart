import 'package:flutter/material.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/ui/home/movie/top_rated_movie.dart';
import 'package:getit/ui/home/widgets/widget_top_home.dart';

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
          children: [WidgetTopHome(), TopRatedMovie()],
        ),
      )),
    );
  }
}
