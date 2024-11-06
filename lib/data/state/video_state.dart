import 'package:getit/data/model/detail_video_movie_model.dart';

class DetailVideosState {
  final bool isLoading;
  final DetailVideoMovie movies;
  final String errorMessage;

  DetailVideosState({
    this.isLoading = false,
    DetailVideoMovie? movies,
    this.errorMessage = '',
  }) : movies = movies ?? DetailVideoMovie();

  DetailVideosState copyWith({
    bool? isLoading,
    DetailVideoMovie? movies,
    String? errorMessage,
  }) {
    return DetailVideosState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
