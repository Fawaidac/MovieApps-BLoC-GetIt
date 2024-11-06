import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getit/data/model/detail_movie_model.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/api_config.dart';
import 'package:getit/utils/date_formatter.dart';
import 'package:getit/utils/extensions.dart';

class DetailMovieHeader extends StatelessWidget {
  final DetailMovie detailMovie;
  const DetailMovieHeader({super.key, required this.detailMovie});

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return SizedBox(
      height: 275,
      width: deviceSize.width,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${detailMovie.backdropPath}',
              fit: BoxFit.cover,
              width: deviceSize.width,
              height: 275,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: whiteColor.withOpacity(0.3),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: whiteColor,
                            size: 20,
                          )),
                    ),
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: whiteColor.withOpacity(0.3),
                    //   child: IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.favorite_border,
                    //         color: whiteColor,
                    //         size: 20,
                    //       )),
                    // )
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${ApiConfig.imageUrl}${detailMovie.posterPath}',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 170,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailMovie.title ?? "",
                            style: AppFonts.montserrat(
                                fontSize: 18,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                formatDate(detailMovie.releaseDate ?? ""),
                                style: AppFonts.montserrat(
                                    fontSize: 12,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                detailMovie.originCountry != null &&
                                        detailMovie.originCountry!.isNotEmpty
                                    ? '(${detailMovie.originCountry!.join(', ')})'
                                    : '(Unknown)',
                                style: AppFonts.montserrat(
                                    fontSize: 12,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 2,
                            children: detailMovie.genres != null
                                ? detailMovie.genres!.map((genre) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: whiteColor),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        genre.name ?? '',
                                        style: AppFonts.montserrat(
                                            fontSize: 11, color: whiteColor),
                                      ),
                                    );
                                  }).toList()
                                : [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: whiteColor),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'No Genres Available',
                                        style: AppFonts.montserrat(
                                            fontSize: 14, color: whiteColor),
                                      ),
                                    ),
                                  ],
                          ),
                          const Gap(5),
                          Text(
                            detailMovie.tagline ?? "",
                            style: AppFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(top: 10),
                          //   // width: 150,
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 10, vertical: 5),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8),
                          //       border:
                          //           Border.all(width: 1, color: whiteColor)),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.favorite,
                          //         color: whiteColor,
                          //         size: 15,
                          //       ),
                          //       const Gap(8),
                          //       Text(
                          //         "Your Favorite",
                          //         style: AppFonts.montserrat(
                          //             fontSize: 12, color: whiteColor),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
