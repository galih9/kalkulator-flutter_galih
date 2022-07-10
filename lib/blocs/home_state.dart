part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadResult extends HomeState {}

class HomeLoaded extends HomeState {
  final String result;
  final String dataCount;
  final String warningMessage;

  const HomeLoaded(
    this.result,
    this.dataCount,
    this.warningMessage,
  );

  @override
  List<Object> get props => [result, dataCount, warningMessage];
}
