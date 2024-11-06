import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/services/cubit/search_movie_cubit.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';

class Search extends StatefulWidget {
  final String query;

  const Search({super.key, required this.query});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMovies();
  }

  void _fetchMovies() {
    final searchCubit = context.read<SearchMovieCubit>();
    searchCubit.fetchSearchMovies(widget.query);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _fetchMovies();
    }
  }

  @override
  void didUpdateWidget(covariant Search oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      _fetchMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: BlocBuilder<SearchMovieCubit, MovieState>(
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
              itemCount: state.hasMoreData
                  ? state.movies.length + 1
                  : state.movies.length,
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
                    // Implement action when a movie is tapped, if needed.
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
