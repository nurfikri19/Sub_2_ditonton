import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/data/datasources/http_ssl_pinning.dart';
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
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/buttom_bar.dart';
import 'package:ditonton/presentation/pages/home_hptv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_hptv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_page_hptv.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_hptv_page.dart';
import 'package:ditonton/presentation/pages/hptv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_hptv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await
  Firebase.initializeApp();
  await
  HTTPSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// bloc movie
        BlocProvider(
          create: (_)
          => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<MovieWatchlistBloc>(),
        ),

        /// bloc tv
        BlocProvider(
          create: (_)
          => di.locator<HptvDetailBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvSearchBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvPopularBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvOnAirBloc>(),
        ),
        BlocProvider(
          create: (_)
          => di.locator<HptvWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme:
          kColorScheme,
          primaryColor:
          kRichBlack,
          scaffoldBackgroundColor:
          kRichBlack,
          textTheme:
          kTextTheme,
        ),
        home: BottomBar(),
        navigatorObservers:
        [routeObserver],
        onGenerateRoute:
            (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder:
                  (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder:
                  (_) => HomeHptvPage());
            case PopularHptvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => PopularHptvPage());
            case TopRatedHptvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => TopRatedHptvPage());
            case HptvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => HptvDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => SearchPage());
            case SearchHptvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder:
                  (_) => SearchHptvPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder:
                  (_) => WatchlistMoviesPage());
            case WatchlistHptvPage.ROUTE_NAME:
              return MaterialPageRoute(builder:
                  (_) => WatchlistHptvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder:
                  (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),

                  ),
                );
              });
          }
        },
      ),
    );
  }
}
