import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String apiUrl = 'https://api.themoviedb.org/3/movie';
  static const String apiSearchUrl = 'https://api.themoviedb.org/3';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w500';
  static String token = dotenv.env['TMDB_API_KEY'] ?? '';
}
