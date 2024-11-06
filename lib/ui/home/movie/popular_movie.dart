import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/cubit/popular_movie_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/home/widgets/load_movie_placeholder.dart';
import 'package:getit/ui/home/widgets/movie_card.dart';

class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<PopularMovie> createState() => PopularMovieState();
}

class PopularMovieState extends State<PopularMovie> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMovieCubit>().fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Popular Movies',
            style: AppFonts.montserrat(
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: BlocBuilder<PopularMovieCubit, MovieState>(
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
                return Center(child: Text(state.errorMessage));
              } else if (state.movies.isEmpty) {
                return Center(
                    child: Text(
                  'No movies available',
                  style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
                ));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: state.movies[index]);
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
