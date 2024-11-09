import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String currentQuery = '';

  void toggleSearch() {
    Future.microtask(() {
      if (mounted) {
        setState(() {
          isSearching = !isSearching;
        });

        if (!isSearching) {
          currentQuery = ''; // Clear the current query when search is closed
          searchController.clear(); // Optionally clear the text field
          context.read<SearchMovieCubit>().clearSearchResults();
          FocusScope.of(context).unfocus();
        }
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
                onChanged: (query) {
                  setState(() {
                    currentQuery = query;
                  });
                  if (query != currentQuery) {
                    context.read<SearchMovieCubit>().fetchSearchMovies(query);
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
              child: Search(query: currentQuery),
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
