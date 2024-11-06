import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/cubit/top_rated_movie_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/home/widgets/load_movie_placeholder.dart';
import 'package:getit/ui/home/widgets/movie_card.dart';

class TopRatedMovie extends StatefulWidget {
  const TopRatedMovie({super.key});

  @override
  State<TopRatedMovie> createState() => _TopRatedMovieState();
}

class _TopRatedMovieState extends State<TopRatedMovie> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    context.read<TopRatedMovieCubit>().fetchTopRatedMovies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<TopRatedMovieCubit>().fetchTopRatedMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Top Rated Movies',
            style: AppFonts.montserrat(
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: BlocBuilder<TopRatedMovieCubit, MovieState>(
            builder: (context, state) {
              if (state.isLoading && state.movies.isEmpty) {
                return ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const LoadMoviePlaceholder();
                  },
                );
              } else if (state.errorMessage.isNotEmpty) {
                return Center(
                    child: Text(
                  state.errorMessage,
                  style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
                ));
              } else if (state.movies.isEmpty) {
                return Center(
                    child: Text(
                  'No movies available',
                  style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
                ));
              } else {
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.movies.length) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: whiteColor,
                      ));
                    } else {
                      return MovieCard(movie: state.movies[index]);
                    }
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
