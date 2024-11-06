import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getit/services/cubit/search_movie_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/ui/home/movie/popular_movie.dart';
import 'package:getit/ui/home/movie/top_rated_movie.dart';
import 'package:getit/ui/home/movie/upcoming_movie.dart';
import 'package:getit/ui/home/search.dart';
import 'package:getit/ui/home/widgets/widget_top_home.dart';

import '../../themes/fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
  final searchController = TextEditingController();

  late SearchMovieCubit searchMovieCubit;

  @override
  void initState() {
    super.initState();
    searchMovieCubit = GetIt.I<SearchMovieCubit>();
  }

  void toggleSearch() {
    Future.microtask(() {
      setState(() {
        isSearching = !isSearching;
      });
      if (!isSearching) {
        searchController.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                controller: searchController,
                style: AppFonts.poppins(fontSize: 14, color: whiteColor),
                onTap: () {
                  if (!isSearching) {
                    toggleSearch();
                  }
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchMovieCubit.fetchSearchMovies(value);
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isSearching ? Icons.close : Icons.search,
                      color: whiteColor,
                    ),
                    onPressed: toggleSearch,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
            ),
            Visibility(
              visible: isSearching,
              child: Search(query: searchController.text),
            ),
            Visibility(
              visible: !isSearching,
              child: const Column(
                children: [
                  TopRatedMovie(),
                  PopularMovie(),
                  UpcomingMovie(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
