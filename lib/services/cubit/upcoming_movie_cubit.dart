import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/model/movie.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/repository/movie_repository.dart';

class UpcomingMovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  UpcomingMovieCubit(this.movieRepository) : super(MovieState());

  int currentPage = 1;

  Future<void> fetchUpcomingMovies() async {
    if (state.isLoading || !state.hasMoreData) return;

    emit(state.copyWith(isLoading: true));

    try {
      final newMovies = await movieRepository.fetchUpcomingMovies(currentPage);

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
}
