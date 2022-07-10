part of 'hptv_detail_bloc.dart';

abstract
class
HptvDetailEvent
    extends Equatable {
  const HptvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetHptvDetailEvent
    extends HptvDetailEvent {
  final int id;

  const
  GetHptvDetailEvent(this.id);

  @override
  List<Object> get props => [];
}