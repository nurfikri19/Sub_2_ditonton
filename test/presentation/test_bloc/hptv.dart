import 'package:ditonton/domain/usecases/hptv/get_hptv_detail.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/usecases/hptv/get_now_playing_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_on_air_bloc.dart';
import 'package:ditonton/domain/usecases/hptv/get_popular_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_popular_bloc.dart';
import 'package:ditonton/domain/usecases/hptv/get_hptv_recomendations.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_recommendation_bloc.dart';
import 'package:ditonton/domain/usecases/hptv/search_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_search_bloc.dart';
import 'package:ditonton/domain/usecases/hptv/get_top_rated_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_top_rated_bloc.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_status_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/get_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/remove_watchlist_hptv.dart';
import 'package:ditonton/domain/usecases/hptv/save_watchlist_hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_watchlist_bloc.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  GetHptvDetail,
  HptvDetailBloc,
  HptvOnAirBloc,
  GetNowPlayingHptv,
  GetPopularHptv,
  HptvPopularBloc,
  HptvRecommendationBloc,
  GetHptvRecommendations,
  HptvSearchBloc,
  SearchHptv,
  GetTopRatedHptv,
  HptvTopRatedBloc,
  HptvWatchlistBloc,
  GetWatchlistHptv,
  GetWatchListStatusHptv,
  RemoveWatchlistHptv,
  SaveWatchlistHptv],
    customMocks: [
      MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}