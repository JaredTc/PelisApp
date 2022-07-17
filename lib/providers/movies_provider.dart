import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pelisapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apikey = '4c9db040f29c6199f90028068235a493';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language, 'page': '4'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson( response.body );

    // print( nowPlayingResponse.results[0].title );


    this.onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }
  getPopularMovies() async{

  }
}
