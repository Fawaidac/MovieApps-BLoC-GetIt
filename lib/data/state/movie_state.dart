import 'package:getit/data/model/detail_movie_model.dart';
import 'package:getit/data/model/movie.dart';

class MovieState {
  final bool isLoading;
  final List<Results> movies;
  final bool hasMoreData;
  final String errorMessage;

  MovieState({
    this.isLoading = false,
    this.movies = const [],
    this.hasMoreData = true,
    this.errorMessage = '',
  });

  factory MovieState.initial() {
    return MovieState(
      isLoading: false,
      movies: [],
      hasMoreData: true,
      errorMessage: '',
    );
  }

  MovieState copyWith({
    bool? isLoading,
    List<Results>? movies,
    bool? hasMoreData,
    String? errorMessage,
  }) {
    return MovieState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DetailMovieState {
  final bool isLoading;
  final DetailMovie movies;
  final String errorMessage;

  DetailMovieState({
    this.isLoading = false,
    DetailMovie? movies,
    this.errorMessage = '',
  }) : movies = movies ?? DetailMovie();

  DetailMovieState copyWith({
    bool? isLoading,
    DetailMovie? movies,
    String? errorMessage,
  }) {
    return DetailMovieState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
