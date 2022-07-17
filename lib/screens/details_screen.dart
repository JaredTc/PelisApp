import 'package:flutter/material.dart';
import 'package:pelisapp/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-novie';

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(),
            _OverView(),
            CastingCards()
            // _PosterAndTitle(),
            // _PosterAndTitle(),
            // _PosterAndTitle(),
            // _PosterAndTitle(),
            ]),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            'movie-title',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/300x400'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'movie.title',
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  ),
              Text(
                  'movie.originalTitle',
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  ),
                  Row(
                    children: [
                      Icon( Icons.star_outline, 
                      size: 15,
                      color: Colors.green,),
                      SizedBox( width: 5),
                      Text('movie-voteAverage', style: Theme.of(context).textTheme.caption,)
                    ],
                  )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal:30, vertical: 10),
      child: Text('Proident ea laborum occaecat exercitation irure sint tempor aliqua. Minim velit enim commodo anim qui pariatur dolore proident consectetur est elit est. Nisi non laborum et consequat. Amet excepteur commodo elit enim duis laboris aute ex est tempor. Aliquip ',
      textAlign:  TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}