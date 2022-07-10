import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:function_tree/function_tree.dart';
import 'package:kalkulator/utils/logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadData>(_onLoadData);
    on<LoadingResult>(_onLoadingResult);
    on<AddNumber>(_onAddNumber);
    on<CalculateResult>(_onCalculateResult);
    on<DeleteNumber>(_onDeleteNumber);
    on<DeleteEverything>(_onDeleteEverything);
  }

  void _onLoadData(LoadData event, Emitter<HomeState> emitter) async {
    await Future.delayed(const Duration(seconds: 1));
    emitter(const HomeLoaded('0', '0', ''));
  }

  Future<void> _onLoadingResult(
      LoadingResult event, Emitter<HomeState> emitter) async {
    if (state is HomeLoadResult) {
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _onAddNumber(AddNumber event, Emitter<HomeState> emitter) {
    if (state is HomeLoaded) {
      final HomeLoaded homeLoaded = state as HomeLoaded;
      String result = homeLoaded.dataCount;
      if (homeLoaded.dataCount == '0') {
        if (CalcUtils.isNumericCanBeCalculated(event.dataCount)) {
          emitter(
            HomeLoaded(
              homeLoaded.result,
              event.dataCount,
              '',
            ),
          );
        } else {
          emitter(HomeLoaded(
            homeLoaded.result,
            homeLoaded.dataCount,
            "dont put operators as the first character!",
          ));
        }
      } else {
        emitter(
          HomeLoaded(
            homeLoaded.result,
            result += event.dataCount,
            '',
          ),
        );
      }
    }
  }

  void _onCalculateResult(
      CalculateResult event, Emitter<HomeState> emitter) async {
    String temp = "";
    String result = "";
    String _tempDataCount = "";
    if (state is HomeLoaded) {
      final HomeLoaded homeLoaded = state as HomeLoaded;
      // change current state into HomeLoadResult
      emitter(HomeLoadResult());
      temp = homeLoaded.dataCount.interpret().toStringAsFixed(2);
      result = (CalcUtils.checkIfLastCharacterIsRoundable(temp)
          ? temp.substring(0, temp.length - 3)
          : temp);
      _tempDataCount = homeLoaded.dataCount;
      // invoke the state
      await _onLoadingResult(LoadingResult(), emitter);
    }
    if (state is HomeLoadResult) {
      emitter(
        HomeLoaded(
          result,
          _tempDataCount,
          '',
        ),
      );
    }
  }

  void _onDeleteNumber(DeleteNumber event, Emitter<HomeState> emitter) {
    if (state is HomeLoaded) {
      final HomeLoaded homeLoaded = state as HomeLoaded;
      String temp = homeLoaded.dataCount;
      if (temp.length > 1) {
        temp = temp.substring(0, temp.length - 1);
      } else {
        temp = '0';
      }
      emitter(HomeLoaded(homeLoaded.result, temp, ''));
    }
  }

  void _onDeleteEverything(
      DeleteEverything event, Emitter<HomeState> emitter) async {
    if (state is HomeLoaded) {
      emitter(HomeLoadResult());
      await _onLoadingResult(LoadingResult(), emitter);
    }
    if (state is HomeLoadResult) {
      emitter(const HomeLoaded('0', '0', ''));
    }
  }
}
