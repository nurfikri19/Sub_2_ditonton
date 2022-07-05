import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_on_air_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_hptv_page.dart';
import 'package:ditonton/presentation/pages/search_page_hptv.dart';
import 'package:ditonton/presentation/pages/top_rated_hptv_page.dart';
import 'package:ditonton/presentation/pages/hptv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_hptv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHptvPage extends StatefulWidget {
  @override
  _HomeHptvPageState createState() => _HomeHptvPageState();
  static const ROUTE_NAME = '/tv';
}


class _HomeHptvPageState extends State<HomeHptvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<HptvOnAirBloc>().add(HptvOnAirGetEvent());
      context.read<HptvPopularBloc>().add(HptvPopularGetEvent());
      context.read<HptvTopRatedBloc>().add(HptvTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Television'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: Text('Watchlist'),
              leading: Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.movie),
                  title: Text('Movie'),
                  onTap: () {
                    Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('Television'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistHptvPage.ROUTE_NAME);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchHptvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tv on Air',
                style: kHeading6,
              ),
              BlocBuilder<HptvOnAirBloc, HptvOnAirState>(
              builder : (context, state) {
                if (state is HptvOnAirLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HptvOnAirLoaded) {
                  return TvList(state.result);
                } else if (state is HptvOnAirError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }), // BlockBuilder
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PopularHptvPage.ROUTE_NAME),
              ),
              BlocBuilder<HptvPopularBloc, HptvPopularState>(
              builder: (context, state) {
                if (state is HptvPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HptvPopularLoaded) {
                  return TvList(state.result);
                } else if (state is HptvPopularError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),// BlockBuilder
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedHptvPage.ROUTE_NAME),
              ),
              BlocBuilder<HptvTopRatedBloc, HptvTopRatedState>(
              builder : (context, state) {
                if (state is HptvTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HptvTopRatedLoaded) {
                  return TvList(state.result);
                } else if (state is HptvTopRatedError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Hptv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HptvDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
