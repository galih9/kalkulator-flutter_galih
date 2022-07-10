part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends HomeEvent {}

class LoadingResult extends HomeEvent {}

class AddNumber extends HomeEvent {
  final String dataCount;

  const AddNumber({
    required this.dataCount,
  });

  @override
  List<Object> get props => [dataCount];
}

class CalculateResult extends HomeEvent {
  const CalculateResult();
}

class DeleteNumber extends HomeEvent {
  final String dataCount;

  const DeleteNumber({
    required this.dataCount,
  });

  @override
  List<Object> get props => [dataCount];
}

class DeleteEverything extends HomeEvent {
  const DeleteEverything();
}
