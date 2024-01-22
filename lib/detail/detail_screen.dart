import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/data/network/api_url.dart';
import 'package:flutter_poc/detail/detail_text_icon_widget.dart';
import 'package:flutter_poc/home/model/movie_list.dart';
import 'package:flutter_poc/theme/sizes.dart';

@RoutePage()
class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.all(Sizes.size15),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 200,
                child: Image.network(
                  ApiUrl.IMAGE_BASE_URL +
                      movie.backdropPath.toString(),
                  fit: BoxFit.contain,
                  height: 200,
                ),
              ),
              Text(movie.title.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size15,
                      fontWeight: FontWeight.bold)),

              Container(
                margin: const EdgeInsets.only(top: Sizes.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailTextIconWidget(iconData: Icons.no_adult_content,
                        text: movie.adult.toString()),
                    DetailTextIconWidget(iconData: Icons.language,
                        text: movie.originalLanguage.toString()),
                    DetailTextIconWidget(iconData: Icons.aspect_ratio,
                        text: movie.popularity.toString()),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: Sizes.size5, bottom: Sizes.size25),
                  child: Text(movie.overview.toString())),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Release Date : ",
                          style:
                          TextStyle(color: Colors.black,
                              fontSize: Sizes.size18)),
                      Center(
                        child: Text(movie.releaseDate.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: Sizes.size15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Rating : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size18,
                          )),
                      Center(
                        child: Text(movie.voteAverage.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: Sizes.size15,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.only(top: Sizes.size25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailTextIconWidget(iconData: Icons.perm_media_outlined,
                        text: movie.mediaType.toString()),
                    Row(
                      children: [
                        const Text("Like"),
                        IconButton(
                            onPressed: () {},
                            // icon:
                            icon: const Icon(Icons.favorite, color: Colors.red))
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
