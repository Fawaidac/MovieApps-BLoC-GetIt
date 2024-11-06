import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/data/state/video_state.dart';
import 'package:getit/services/repository/movie_repository.dart';

class DetailVideoCubit extends Cubit<DetailVideosState> {
  final MovieRepository movieRepository;

  DetailVideoCubit(this.movieRepository) : super(DetailVideosState());

  Future<void> getVideosMovies(int movieId) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final newMovies = await movieRepository.getVideoDetailMovie(movieId);

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
