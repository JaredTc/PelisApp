import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pelisapp/models/models.dart';
import 'package:pelisapp/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apikey = 'your-api-key';
  // String _baseUrl = 'api.themoviedb.org';
  String _language = 'en-EN';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> getJsonData(String endpoint, [int page = 2]) async {
    final data = {'api_key': _apikey, 'language': _language, 'page': '$page'};

    final url = Uri.https('api.themoviedb.org', endpoint, data);

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

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await this.getJsonData(
      '3/movie/$movieId/credits',
    );
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {

    final data = {'api_key': _apikey, 'language': _language, 'query': query };

    final url = Uri.https('api.themoviedb.org', '3/search/movie/', data);
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson( response.body );

    return searchResponse.results;
  }
}
