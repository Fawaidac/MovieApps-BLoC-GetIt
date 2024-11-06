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
}
