import 'package:flutter/material.dart';
import 'package:pelisapp/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(
                widget.movies[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 260,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.popAndPushNamed(context, 'details',
                arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 150,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // Text(
          //   movie.title,
          //   style: TextStyle(
          //     fontSize: 20
          //   ),
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
