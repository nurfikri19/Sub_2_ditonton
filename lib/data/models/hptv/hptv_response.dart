import 'package:ditonton/data/models/hptv/hptv_model.dart';
import 'package:equatable/equatable.dart';

class HptvResponse extends Equatable {
  final List<HptvModel> tvList;

  HptvResponse({required this.tvList});

  factory HptvResponse.fromJson(Map<String, dynamic> json) => HptvResponse(
    tvList: List<HptvModel>.from((json["results"] as List)
        .map((x) => HptvModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvList];
}
