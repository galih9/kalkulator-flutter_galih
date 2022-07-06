import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:function_tree/function_tree.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitialState()) {
    on<HomeCalculateEvent>(_onCalculate);
    on<HomeInsertNumberEvent>(_onInsertNumber);
    on<HomeDeleteNumberEvent>(_onDeleteNumber);
  }
// dispatchers
  void _onCalculate(
    HomeCalculateEvent event,
    Emitter<HomeState> emitter,
  ) async {
    String temp = event.dataCount.interpret().toStringAsFixed(2);
    String _result = (checkIfLastCharacterIsRoundable(temp))
        ? temp.substring(0, temp.length - 3)
        : temp;
    emitter(const HomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    emitter(
      HomeLoadedState(
        _result,
        event.dataCount,
      ),
    );
  }

  void _onInsertNumber(
    HomeInsertNumberEvent event,
    Emitter<HomeState> emitter,
  ) {
    String countTemp = event.dataCount;
    String temp = event.number;
    String newDataCount;
    if (countTemp == '0') {
      newDataCount = temp;
    } else {
      newDataCount = countTemp += temp;
    }
    print("newDataCount: $newDataCount $temp $countTemp");

    emitter(
      HomeLoadedState(
        event.result,
        newDataCount,
      ),
    );
  }

  void _onDeleteNumber(
    HomeDeleteNumberEvent event,
    Emitter<HomeState> emitter,
  ) {
    String temp = removeLastCharacter(event.dataCount);
    emitter(
      HomeLoadedState(
        event.result,
        temp,
      ),
    );
  }

// functions
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    if (string == ".") {
      return false;
    }
    if (string == "-") {
      return false;
    }

    return numericRegex.hasMatch(string);
  }

  String removeLastCharacter(String string) {
    if (string.length == 1) {
      return "0";
    }
    return string.substring(0, string.length - 1);
  }

  bool checkIfLastCharacterIsRoundable(String string) {
    if (string.length == 1) {
      return false;
    }
    if (string.substring(string.length - 2, string.length) == "00") {
      return true;
    }
    return false;
  }
}
