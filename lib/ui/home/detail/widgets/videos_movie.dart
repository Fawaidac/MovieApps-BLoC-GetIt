import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getit/data/state/video_state.dart';
import 'package:getit/services/cubit/detail_video_cubit.dart';
import 'package:getit/themes/colors.dart';
import 'package:getit/themes/fonts.dart';
import 'package:getit/utils/date_formatter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosMovie extends StatefulWidget {
  final int movieId;
  const VideosMovie({super.key, required this.movieId});

  @override
  State<VideosMovie> createState() => _VideosMovieState();
}

class _VideosMovieState extends State<VideosMovie> {
  late DetailVideoCubit detailVideoCubit;
  YoutubePlayerController? ytController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailVideoCubit = context.read<DetailVideoCubit>();
    detailVideoCubit.getVideosMovies(widget.movieId);
  }

  @override
  void dispose() {
    ytController?.dispose();
    super.dispose();
  }

  void initializeYoutubePlayer(String videoKey) {
    ytController = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      margin: const EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: BlocBuilder<DetailVideoCubit, DetailVideosState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: whiteColor),
            );
          } else if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                "Error: ${state.errorMessage}",
                style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
              ),
            );
          } else if (state.movies.results != null) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.movies.results?.length ?? 0,
              itemBuilder: (context, index) {
                final video = state.movies.results![index];
                final videoKey = video.key;
                if (videoKey != null && ytController == null) {
                  initializeYoutubePlayer(videoKey);
                }
                return SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // ignore: unnecessary_null_comparison
                          if (videoKey != null) {
                            initializeYoutubePlayer(videoKey);
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 150,
                          width: 250,
                          margin: const EdgeInsets.only(right: 10),
                          child: ytController != null &&
                                  ytController!.initialVideoId == videoKey
                              ? YoutubePlayer(
                                  controller: ytController!,
                                  showVideoProgressIndicator: true,
                                )
                              : Container(
                                  color: secondaryColor.withOpacity(0.7),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/youtube.png",
                                        height: 50,
                                      ),
                                      Text(
                                        "Tap to play",
                                        style: AppFonts.montserrat(
                                          fontSize: 12,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatDate(video.publishedAt ?? ""),
                            style: AppFonts.montserrat(
                                fontSize: 11,
                                color: whiteColor,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            video.name ?? 'No Title',
                            style: AppFonts.montserrat(
                                fontSize: 12,
                                color: whiteColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                // return const SizedBox.shrink();
              },
            );
          }
          return Center(
            child: Text(
              "No videos available.",
              style: AppFonts.montserrat(fontSize: 12, color: whiteColor),
            ),
          );
        },
      ),
    );
  }
}
