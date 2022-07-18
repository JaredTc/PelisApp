import 'package:flutter/material.dart';
import 'package:pelisapp/providers/movies_provider.dart';
import 'package:pelisapp/screens/screens.dart';
import 'package:pelisapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);


    return Scaffold(
     
      appBar: AppBar(
      
        title: Text('Now Showing', 
        style: TextStyle(color: Colors.black,
        fontSize: 33),),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, 
        icon: Icon(Icons.search_outlined),
        iconSize: 33,
        color: Colors.black,)],
        
      ),
      body:  SingleChildScrollView(
        child: Column(
        children: [
          // CardSwiper
          CardSwiper( movies: moviesProvider.onDisplayMovies ),

          //Lista Horizontal
          MovieSlider( movies: moviesProvider.popularMovies,
           title: 'Populars'
            ,
          onNextPage: () => moviesProvider.getPopularMovies(),),
         
        ],
      )
      )
    );
  }
}