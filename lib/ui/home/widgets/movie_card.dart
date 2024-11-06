import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:getit/data/model/movie.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/api_config.dart';
import 'package:getit/utils/date_formatter.dart';

class MovieCard extends StatelessWidget {
  final Results movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DetailMovieScreen(movieId: movie.id ?? 0),
        //     ));
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.posterPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${ApiConfig.imageUrl}${movie.posterPath}',
                      fit: BoxFit.cover,
                      width: 120,
                      height: 170,
                    ),
                  )
                : CardLoading(
                    height: 170,
                    width: 120,
                    borderRadius: BorderRadius.circular(10),
                  ),
            const SizedBox(height: 8),
            Text(
              movie.title ?? '',
              style: AppFonts.montserrat(
                fontSize: 12,
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Rating: ${(movie.voteAverage! * 10).toStringAsFixed(0)}%',
              style: AppFonts.montserrat(
                fontSize: 10,
                color: whiteColor,
              ),
            ),
            Text(
              formatDate(movie.releaseDate ?? ""),
              style: AppFonts.montserrat(
                fontSize: 10,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
