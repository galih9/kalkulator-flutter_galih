part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();

  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState({required this.message});

  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final String result;
  final String newDataCount;

  const HomeLoadedState(this.result, this.newDataCount);

  @override
  List<Object?> get props => [];
}

class HomeInsertNumberState extends HomeState {
  final String number;

  const HomeInsertNumberState({required this.number});

  @override
  List<Object?> get props => [];
}

class HomeDeleteNumberState extends HomeState {
  final String number;
  final String dataCount;

  const HomeDeleteNumberState(this.dataCount, this.number);

  @override
  List<Object?> get props => [];
}