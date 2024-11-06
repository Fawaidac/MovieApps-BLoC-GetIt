import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/cubit/detail_movie_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/home/detail/widgets/detail_movie_header.dart';
import 'package:getit/ui/home/detail/widgets/recommendations_movie.dart';
import 'package:getit/ui/home/detail/widgets/videos_movie.dart';
import 'package:getit/utils/extensions.dart';

class DetailMovie extends StatefulWidget {
  final int movieId;
  const DetailMovie({super.key, required this.movieId});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  late DetailMovieCubit detailMovieCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailMovieCubit = context.read<DetailMovieCubit>();
    detailMovieCubit.getDetailMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: whiteColor,
              ));
            } else if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text(
                "Error: ${state.errorMessage}",
                style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
              ));
            } else if (state.movies != null) {
              final movie = state.movies;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movie.backdropPath != null
                      ? DetailMovieHeader(detailMovie: movie)
                      : CardLoading(
                          height: 250,
                          width: deviceSize.width,
                        ),
                  VideosMovie(movieId: widget.movieId),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: whiteColor,
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: primaryColor,
                                child: Text(
                                  movie.voteAverage != null
                                      ? '${(movie.voteAverage! * 10).toStringAsFixed(0)}%'
                                      : 'N/A',
                                  style: AppFonts.montserrat(
                                      fontSize: 14,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "Vote\nAverage",
                              style: AppFonts.montserrat(
                                  fontSize: 14, color: whiteColor),
                            ),
                          ],
                        ),
                        const Gap(14),
                        Text(
                          movie.overview ?? "",
                          style: AppFonts.montserrat(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.normal),
                        ),
                        RecommendationsMovie(movieId: widget.movieId)
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
                child: Text(
              "No movie details available.",
              style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
            ));
          },
        ),
      )),
    );
  }
}
