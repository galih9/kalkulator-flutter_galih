part of 'home_bloc.dart';

// events
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeCalculateEvent extends HomeEvent {
  final String number;
  final String dataCount;

  const HomeCalculateEvent(this.dataCount, this.number);

  @override
  List<Object?> get props => [];
}

class HomeInsertNumberEvent extends HomeEvent {
  final String number;
  final String dataCount;
  final String result;

  const HomeInsertNumberEvent(this.dataCount, this.number, this.result);
  @override
  List<Object?> get props => [];
}

class HomeDeleteNumberEvent extends HomeEvent {
  final String result;
  final String dataCount;

  const HomeDeleteNumberEvent(this.dataCount, this.result);
  @override
  List<Object?> get props => [];
}
