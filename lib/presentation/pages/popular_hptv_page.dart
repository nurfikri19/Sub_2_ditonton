import 'package:ditonton/presentation/bloc/hptv/hptv_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/hptv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularHptvPage
    extends StatefulWidget {
  static
  const ROUTE_NAME
  = '/popular-tv';

  @override
  _PopularHptvPageState createState()
  => _PopularHptvPageState();
}

class _PopularHptvPageState
    extends State<PopularHptvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<HptvPopularBloc>().add(HptvPopularGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HptvPopularBloc, HptvPopularState>(
          builder: (context, state) {
            if (state is HptvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else
              if (state is HptvPopularLoaded) {
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
