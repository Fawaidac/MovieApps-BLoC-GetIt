import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/model/movie.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/repository/search_repository.dart';

class SearchMovieCubit extends Cubit<MovieState> {
  final SearchRepository searchRepository;

  SearchMovieCubit(this.searchRepository) : super(MovieState());

  int currentPage = 1;

  Future<void> fetchSearchMovies(String query) async {
    if (state.isLoading || !state.hasMoreData) return;

    emit(MovieState(isLoading: true));

    try {
      final newMovies = await searchRepository.searchMovie(query, currentPage);

      final updatedMovies = List<Results>.from(state.movies)
        ..addAll(newMovies.results!);

      emit(MovieState(
        isLoading: false,
        movies: updatedMovies,
        hasMoreData: newMovies.results!.length >= 10,
      ));

      currentPage++;
    } catch (error) {
      emit(MovieState(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }
}
