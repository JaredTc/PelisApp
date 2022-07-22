import 'package:flutter/material.dart';
import 'package:pelisapp/models/models.dart';
import 'package:pelisapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('builResults');
  }

  Widget _EmptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      _EmptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context);
    moviesProvider.getSuggestionsByQuery( query );
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _EmptyContainer();
        final movie = snapshot.data!;
        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: ( _, int index ) => _SuggestionItem(movie[index])
          );
      },
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final movie;

  const _SuggestionItem( this.movie );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(placeholder: AssetImage('assets/no-image.jpg'),
       image: NetworkImage( movie.fullPosterImg ),
       width: 50,
       fit: BoxFit.cover,),
       title: Text( movie.title ),
       subtitle: Text( movie.originalTitle ),
       onTap: (){
       Navigator.pushNamed(context, 'details', arguments: movie );
       },
    );
  }
}