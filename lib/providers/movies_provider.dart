import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pelisapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = 'YOUR-APIKEY';
  // String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-EN';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> getJsonData(String endpoint, [int page = 2]) async {
    
    final data = {'api_key': _apikey, 'language': _language, 'page': '$page'};

    var url = Uri.https('api.themoviedb.org', endpoint, data);

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this.getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    this.onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this.getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    this.popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }
}
