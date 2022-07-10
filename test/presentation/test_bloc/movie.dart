import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';


@GenerateMocks([MovieDetailBloc,
  GetMovieDetail,
  MovieNowPlayingBloc,
  GetNowPlayingMovies,
  MoviePopularBloc,
  GetPopularMovies,
  MovieRecommendationBloc,
  GetMovieRecommendations,
  MovieSearchBloc,
  SearchMovies,
  GetTopRatedMovies,
  MovieTopRatedBloc,
  MovieWatchlistBloc,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist],
    customMocks: [
      MockSpec<http.Client>(as: #MockHttpClient)
    ])
void main() {}