import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HptvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  HptvDetailPage({required this.id});

  @override
  _HptvDetailPageState createState() => _HptvDetailPageState();
}

class _HptvDetailPageState extends State<HptvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<HptvDetailBloc>()
          .add(GetHptvDetailEvent(widget.id));
      context
          .read<HptvRecommendationBloc>()
          .add(GetHptvRecommendationEvent(widget.id));
      context
          .read<HptvWatchlistBloc>()
          .add(GetStatusTvEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    HptvRecommendationState hptvRecommendations =
        context.watch<HptvRecommendationBloc>().state;
    return Scaffold(
      body: BlocListener<HptvWatchlistBloc, HptvWatchlistState>(
        listener: (_, state) {
          if (state is HptvWatchlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            context
                .read<HptvWatchlistBloc>()
                .add(GetStatusTvEvent(widget.id));
          }
        },
        child: BlocBuilder<HptvDetailBloc, HptvDetailState>(
          builder: (context, state) {
            if (state is HptvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HptvDetailLoaded) {
              final tv = state.hptvDetail;
              bool isAddedToWatchlistHptv = (context.watch<HptvWatchlistBloc>().state
              is HptvWatchlistStatusLoaded)
                  ? (context.read<HptvWatchlistBloc>().state
              as HptvWatchlistStatusLoaded)
                  .result
                  : false;
              return SafeArea(
                child: DetailContent(
                  tv,
                  hptvRecommendations is HptvRecommendationLoaded
                      ? hptvRecommendations.tv
                      : List.empty(),
                  isAddedToWatchlistHptv,
                ),
              );
            } else {
              return Text("Empty");
            }
          },
        ),
      ),);
  }
}

class DetailContent extends StatelessWidget {
  final HptvDetail tv;
  final List<Hptv> recommendations;
  final bool isAddedWatchlistHptv;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlistHptv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error_outlined),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlistHptv) {
                                  BlocProvider.of<HptvWatchlistBloc>(context)
                                    ..add(AddItemTvEvent(tv));
                                } else {
                                  BlocProvider.of<HptvWatchlistBloc>(context)
                                    ..add(RemoveItemHptvEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlistHptv
                                      ? Icon(Icons.check_outlined)
                                      : Icon(Icons.add_outlined),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              (tv.firstAirDate),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_border_outlined,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<HptvRecommendationBloc,
                                HptvRecommendationState>(
                              builder: (context, state) {
                                if (state is HptvRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is HptvRecommendationError) {
                                  return Text(state.message);
                                } else if (state is HptvRecommendationLoaded) {
                                  final recommendations = state.tv;
                                  if (recommendations.isEmpty) {
                                    return const Text("No tv recommendations");
                                  }
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                HptvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error_outlined),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor
                : kRichBlack,
            foregroundColor
                : Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
