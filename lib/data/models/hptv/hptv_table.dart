import 'package:ditonton/domain/entities/hptv/hptv.dart';
import 'package:ditonton/domain/entities/hptv/hptv_detail.dart';
import 'package:equatable/equatable.dart';

class HptvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  HptvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory HptvTable.fromEntity(HptvDetail tv) => HptvTable(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory HptvTable.fromMap(Map<String, dynamic> map) => HptvTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Hptv toEntity() => Hptv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
