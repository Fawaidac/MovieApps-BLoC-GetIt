import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/services/cubit/search_movie_cubit.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/ui/home/detail/detail_movie.dart';

class Search extends StatefulWidget {
  final String query;

  const Search({super.key, required this.query});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchMovies();
  }

  void _fetchMovies() {
    if (widget.query.isNotEmpty) {
      final searchCubit = context.read<SearchMovieCubit>();
      searchCubit.clearSearchResults();
      searchCubit.fetchSearchMovies(widget.query);
    }
  }

  @override
  void didUpdateWidget(covariant Search oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      _fetchMovies();
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<SearchMovieCubit>().fetchSearchMovies(widget.query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: BlocBuilder<SearchMovieCubit, MovieState>(
        // bloc: GetIt.I<SearchMovieCubit>(),
        builder: (context, state) {
          if (state.isLoading && state.movies.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: whiteColor,
              ),
            );
          } else if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessage,
                style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
              ),
            );
          } else if (state.movies.isEmpty) {
            return Center(
              child: Text(
                'No movies found.',
                style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
              ),
            );
          } else {
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.movies.length + (state.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.movies.length) {
                  return Center(
                    child: CircularProgressIndicator(color: whiteColor),
                  );
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
                    style: AppFonts.montserrat(fontSize: 14, color: whiteColor),
                  ),
                  subtitle: Text(
                    'Release Date: ${movie.releaseDate ?? 'N/A'}',
                    style:
                        AppFonts.montserrat(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailMovie(movieId: movie.id ?? 0),
                        ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
