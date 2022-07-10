import 'package:ditonton/presentation/bloc/hptv/hptv_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/hptv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedHptvPage
    extends StatefulWidget {
  static
  const ROUTE_NAME
  = '/top-rated-tv';

  @override
  _TopRatedHptvPageState createState()
  => _TopRatedHptvPageState();
}

class _TopRatedHptvPageState
    extends State<TopRatedHptvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HptvTopRatedBloc>().add(HptvTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HptvTopRatedBloc, HptvTopRatedState>(
          builder: (context, state) {
            if (state is HptvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HptvTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.result[index];
                  return HptvCard(tvs);
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
}
