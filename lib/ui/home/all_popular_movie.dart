import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/cubit/popular_movie_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/api_config.dart';

class AllPopularMovie extends StatefulWidget {
  const AllPopularMovie({super.key});

  @override
  State<AllPopularMovie> createState() => _AllPopularMovieState();
}

class _AllPopularMovieState extends State<AllPopularMovie> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    context.read<PopularMovieCubit>().fetchPopularMovies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<PopularMovieCubit>().fetchPopularMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Popular Movie",
          style: AppFonts.montserrat(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: whiteColor,
          ),
        ),
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: BlocBuilder<PopularMovieCubit, MovieState>(
          builder: (context, state) {
            if (state.isLoading && state.movies.isEmpty) {
              return ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return loadDataMovie();
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
                scrollDirection: Axis.vertical,
                itemCount: state.movies.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.movies.length) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: whiteColor,
                    ));
                  } else {
                    final movie = state.movies[index];
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          movie.posterPath != null
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 120,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${ApiConfig.imageUrl}${movie.posterPath}'),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          primaryColor.withOpacity(0.8),
                                      child: Text(
                                        '${index + 1}',
                                        style: AppFonts.montserrat(
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              : CardLoading(
                                  height: 170,
                                  width: 120,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title ?? '',
                                  style: AppFonts.montserrat(
                                    fontSize: 16,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rating: ${(movie.voteAverage! * 10).toStringAsFixed(0)}%',
                                  style: AppFonts.montserrat(
                                    fontSize: 14,
                                    color: whiteColor,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  movie.overview ?? "",
                                  style: AppFonts.montserrat(
                                    fontSize: 12,
                                    color: whiteColor,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      )),
    );
  }

  Widget loadDataMovie() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardLoading(
            height: 170,
            width: 120,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardLoading(
                  height: 15,
                  width: 120,
                  borderRadius: BorderRadius.circular(5),
                  margin: const EdgeInsets.only(bottom: 3),
                ),
                CardLoading(
                  margin: const EdgeInsets.only(bottom: 3),
                  height: 10,
                  width: 80,
                  borderRadius: BorderRadius.circular(5),
                ),
                CardLoading(
                    height: 10,
                    width: 100,
                    borderRadius: BorderRadius.circular(5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
