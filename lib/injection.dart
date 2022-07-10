import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/database_helper_hptv.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/http_ssl_pinning.dart';
import 'package:ditonton/data/datasources/hptv/hptv_local_data_source.dart';
import 'package:ditonton/data/datasources/hptv/hptv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/hptv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/hptv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/hptv/get_now_playing_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_popular_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_top_rated_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_detail.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_recomendations.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_status_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/remove_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/save_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/search_hptv.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_on_air_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => MovieDetailBloc(
    getMovieDetail: locator(),
  ));
  locator.registerFactory(
        () => MovieNowPlayingBloc(locator()),
  );
  locator.registerFactory(
        () => MoviePopularBloc(locator()),
  );
  locator.registerFactory(() => MovieRecommendationBloc(
    getMovieRecommendations: locator(),
  ));
  locator.registerFactory(() => MovieSearchBloc(
    searchMovies: locator(),
  ));
  locator.registerFactory(
        () => MovieTopRatedBloc(locator()),
  );
  locator.registerFactory(() => HptvDetailBloc(
    getHptvDetail: locator(),
  ));
  locator.registerFactory(
        () => HptvOnAirBloc(locator()),
  );
  locator.registerFactory(
        () => HptvPopularBloc(locator()),
  );
  locator.registerFactory(() => HptvRecommendationBloc(
    getHptvRecommendations: locator(),
  ));
  locator.registerFactory(() => HptvSearchBloc(
    searchHptv: locator(),
  ));
  locator.registerFactory(
        () => HptvTopRatedBloc(locator()),
  );
  locator.registerFactory(() => MovieWatchlistBloc(
    getWatchlistMovies: locator(),
    getWatchListStatus: locator(),
    saveWatchlist: locator(),
    removeWatchlist: locator(),
  ));
  locator.registerFactory(() => HptvWatchlistBloc(
    getWatchlistHptv: locator(),
    getWatchListStatus: locator(),
    saveWatchlist: locator(),
    removeWatchlist: locator(),
  ));



  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingHptv(locator()));
  locator.registerLazySingleton(() => GetPopularHptv(locator()));
  locator.registerLazySingleton(() => GetTopRatedHptv(locator()));
  locator.registerLazySingleton(() => GetHptvDetail(locator()));
  locator.registerLazySingleton(() => GetHptvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchHptv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusHptv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistHptv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistHptv(locator()));
  locator.registerLazySingleton(() => GetWatchlistHptv(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<HptvRepository>(
        () => HptvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<HptvRemoteDataSource>(
          () => HptvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<HptvLocalDataSource>(
          () => HptvLocalDataSourceImpl(databaseHelperhptv: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(()
  => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperHptv>(()
  => DatabaseHelperHptv());

  // external
  locator.registerLazySingleton(() => HTTPSSLPinning.client);
}
