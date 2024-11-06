import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/state/movie_state.dart';
import 'package:getit/services/repository/movie_repository.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final MovieRepository movieRepository;

  DetailMovieCubit(this.movieRepository) : super(DetailMovieState());

  Future<void> getDetailMovies(int movieId) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final newMovies = await movieRepository.getDetailMovie(movieId);

      emit(state.copyWith(
        isLoading: false,
        movies: newMovies,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    }
  }
}
