import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getit/services/cubit/search_movie_cubit.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/home/detail/detail_movie.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (searchController.text.isNotEmpty) {
        context
            .read<SearchMovieCubit>()
            .fetchSearchMovies(searchController.text);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: darkColor,
              child: Icon(Icons.keyboard_arrow_left, color: whiteColor),
            ),
          ),
        ),
        title: Text(
          "Search Movie",
          style: AppFonts.poppins(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: TextFormField(
              controller: searchController,
              style: AppFonts.poppins(fontSize: 14, color: whiteColor),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: whiteColor),
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      context
                          .read<SearchMovieCubit>()
                          .fetchSearchMovies(searchController.text);
                    } else {
                      Fluttertoast.showToast(msg: "Is Required");
                    }
                  },
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
          Expanded(
            child: BlocBuilder<SearchMovieCubit, MovieState>(
              builder: (context, state) {
                if (state.isLoading && state.movies.isEmpty) {
                  return Center(
                      child: CircularProgressIndicator(color: whiteColor));
                } else if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(state.errorMessage,
                        style: AppFonts.montserrat(
                            fontSize: 12, color: whiteColor)),
                  );
                } else if (state.movies.isEmpty) {
                  return Center(
                    child: Text("No movies found.",
                        style: AppFonts.montserrat(
                            fontSize: 12, color: whiteColor)),
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.movies.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.movies.length) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: whiteColor));
                      }
                      final movie = state.movies[index];
                      return ListTile(
                        leading: movie.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                width: 50,
                              )
                            : const Icon(Icons.movie),
                        title: Text(
                          movie.title ?? 'Unknown Title',
                          style: AppFonts.montserrat(
                              fontSize: 14, color: whiteColor),
                        ),
                        subtitle: Text(
                          'Release Date: ${movie.releaseDate ?? 'N/A'}',
                          style: AppFonts.montserrat(
                              fontSize: 12, color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailMovie(movieId: movie.id ?? 0),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
