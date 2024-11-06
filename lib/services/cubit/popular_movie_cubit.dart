import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/model/movie.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/repository/movie_repository.dart';

class PopularMovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  PopularMovieCubit(this.movieRepository) : super(MovieState());

  int currentPage = 1;

  Future<void> fetchPopularMovies() async {
    if (state.isLoading || !state.hasMoreData) return;

    emit(MovieState(isLoading: true));

    try {
      final newMovies = await movieRepository.fetchPopularMovies(currentPage);

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
