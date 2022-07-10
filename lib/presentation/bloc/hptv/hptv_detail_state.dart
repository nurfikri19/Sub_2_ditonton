part of 'hptv_detail_bloc.dart';

abstract
class HptvDetailState
    extends Equatable {
  const HptvDetailState();

  @override
  List<Object> get props => [];
}

class HptvDetailEmpty
    extends HptvDetailState {}

class HptvDetailLoading
    extends HptvDetailState {}

class HptvDetailError
    extends HptvDetailState {
  final
  String message;

  const HptvDetailError(this.message);

  @override
  List<Object> get props
  => [message];
}

class HptvDetailLoaded
    extends HptvDetailState {
  final HptvDetail hptvDetail;

  const HptvDetailLoaded(this.hptvDetail);

  @override
  List<Object> get props
  => [hptvDetail];
}