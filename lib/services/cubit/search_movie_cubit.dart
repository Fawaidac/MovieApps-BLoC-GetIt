import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/model/movie.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/repository/search_repository.dart';

class SearchMovieCubit extends Cubit<MovieState> {
  final SearchRepository searchRepository;

  SearchMovieCubit(this.searchRepository) : super(MovieState());

  int currentPage = 1;

  void clearSearchResults() {
    emit(MovieState());
  }

  Future<void> fetchSearchMovies(String query) async {
    if (state.isLoading || !state.hasMoreData) return;

    emit(state.copyWith(isLoading: true));

    try {
      final newMovies = await searchRepository.searchMovie(query, currentPage);

      final updatedMovies = List<Results>.from(state.movies)
        ..addAll(newMovies.results!);

      emit(state.copyWith(
        isLoading: false,
        movies: updatedMovies,
        hasMoreData: newMovies.results!.length >= 10,
      ));

      currentPage++;
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }

  void reset() {
    currentPage = 1;
    emit(MovieState.initial());
  }
}
