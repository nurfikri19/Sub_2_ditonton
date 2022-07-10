import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/hptv/hptv_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/hptv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistHptvPage
    extends StatefulWidget {
  static
  const ROUTE_NAME
  = '/watchlist-tv';

  @override
  _WatchlistHptvPageState createState()
  => _WatchlistHptvPageState();
}

class _WatchlistHptvPageState
    extends State<WatchlistHptvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HptvWatchlistBloc>().add(GetListEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<HptvWatchlistBloc>().add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HptvWatchlistBloc, HptvWatchlistState>(
          builder: (context, state) {
            if (state is HptvWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HptvWatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return HptvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
