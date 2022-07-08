import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';
import 'package:kalkulator/screens/home/web/web_view.dart';
import 'package:kalkulator/screens/home/windows/win_views.dart';
import 'package:kalkulator/screens/widgets/home_widgets.dart';
import 'package:kalkulator/utils/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:sizer/sizer.dart';

part './mobile/mobile_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dataToCount = "0";
  String _result = "0";
  final List<String> _list = CalcUtils.getButtonLabels();
  final List<String> _listLandscape = CalcUtils.getButtonLandscapeLabels();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraint) {
          return WebViewCalc(
            result: _result,
            dataCount: _dataToCount,
            constraints: constraint,
            buttons: GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              children: [
                for (var i in _listLandscape)
                  Container(
                    margin: EdgeInsets.all(1.h),
                    child: CalculatorButtons(
                      btnStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ((CalcUtils.isNumericUsingRegularExpression(i))
                              ? Colors.blueGrey
                              : (i == "=")
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      label: i,
                      fontSize: (constraint.maxWidth > 600) ? 3.sp : 12.sp,
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (_dataToCount == "0") {
                              if (CalcUtils.isNumericUsingRegularExpression(
                                  i)) {
                                _dataToCount = i;
                              } else {
                                CustomLogger.warning(
                                  "angka di harus awal, gak boleh operator",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the first character!",
                                );
                              }
                            } else if (i == "Del") {
                              _dataToCount =
                                  CalcUtils.removeLastCharacter(_dataToCount);
                            } else if (i == "CE") {
                              _dataToCount = "0";
                              _result = "0";
                            } else if (i == "=") {
                              if (CalcUtils.checkIfLastCharacterIsOperator(
                                  _dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    _dataToCount.interpret().toStringAsFixed(2);
                                _result =
                                    (CalcUtils.checkIfLastCharacterIsRoundable(
                                            temp))
                                        ? temp.substring(0, temp.length - 3)
                                        : temp;
                                CustomLogger.info("get result $_result");
                              }
                            } else {
                              _dataToCount += i;
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    } else if (Platform.isAndroid) {
      return OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: SystemUiOverlay.values,
            ); // to re-show bars
          } else {
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: [
                SystemUiOverlay.top,
                SystemUiOverlay.bottom,
              ],
            );
          }
          return MobileViewCalc(
            orientation: orientation,
            result: _result,
            dataCount: _dataToCount,
            buttons: GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 4 : 5,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              children: [
                if (orientation == Orientation.landscape)
                  for (var i in _listLandscape)
                    CalculatorButtons(
                      btnStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ((CalcUtils.isNumericUsingRegularExpression(i))
                              ? Colors.blueGrey
                              : (i == "=")
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      label: i,
                      fontSize: 13.sp,
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (_dataToCount == "0") {
                              if (CalcUtils.isNumericUsingRegularExpression(
                                  i)) {
                                _dataToCount = i;
                              } else {
                                CustomLogger.warning(
                                  "angka di harus awal, gak boleh operator",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the first character!",
                                );
                              }
                            } else if (i == "Del") {
                              _dataToCount =
                                  CalcUtils.removeLastCharacter(_dataToCount);
                            } else if (i == "CE") {
                              _dataToCount = "0";
                              _result = "0";
                            } else if (i == "=") {
                              if (CalcUtils.checkIfLastCharacterIsOperator(
                                  _dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    _dataToCount.interpret().toStringAsFixed(2);
                                _result =
                                    (CalcUtils.checkIfLastCharacterIsRoundable(
                                            temp))
                                        ? temp.substring(0, temp.length - 3)
                                        : temp;
                                CustomLogger.info("get result $_result");
                              }
                            } else {
                              _dataToCount += i;
                            }
                          },
                        );
                      },
                    )
                else
                  for (var i in _list)
                    CalculatorButtons(
                      btnStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ((CalcUtils.isNumericUsingRegularExpression(i))
                              ? Colors.blueGrey
                              : (i == "=")
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      label: i,
                      fontSize: 13.sp,
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (_dataToCount == "0") {
                              if (CalcUtils.isNumericUsingRegularExpression(
                                  i)) {
                                _dataToCount = i;
                              } else {
                                CustomLogger.warning(
                                  "angka di harus awal, gak boleh operator",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the first character!",
                                );
                              }
                            } else if (i == "Del") {
                              _dataToCount =
                                  CalcUtils.removeLastCharacter(_dataToCount);
                            } else if (i == "CE") {
                              _dataToCount = "0";
                              _result = "0";
                            } else if (i == "=") {
                              if (CalcUtils.checkIfLastCharacterIsOperator(
                                  _dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    _dataToCount.interpret().toStringAsFixed(2);
                                _result =
                                    (CalcUtils.checkIfLastCharacterIsRoundable(
                                            temp))
                                        ? temp.substring(0, temp.length - 3)
                                        : temp;
                                CustomLogger.info("get result $_result");
                              }
                            } else {
                              _dataToCount += i;
                            }
                          },
                        );
                      },
                    ),
              ],
            ),
          );
        },
      );
    } else if (Platform.isWindows) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraint) {
          return WinViewCalc(
            result: _result,
            dataCount: _dataToCount,
            constraints: constraint,
            buttons: GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              children: [
                for (var i in _listLandscape)
                  Container(
                    margin: EdgeInsets.all(1.w),
                    child: CalculatorButtons(
                      btnStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ((CalcUtils.isNumericUsingRegularExpression(i))
                              ? Colors.blueGrey
                              : (i == "=")
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      label: i,
                      fontSize: (constraint.maxWidth > 600) ? 10.sp : 12.sp,
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (_dataToCount == "0") {
                              if (CalcUtils.isNumericUsingRegularExpression(
                                  i)) {
                                _dataToCount = i;
                              } else {
                                CustomLogger.warning(
                                  "angka di harus awal, gak boleh operator",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the first character!",
                                );
                              }
                            } else if (i == "Del") {
                              _dataToCount =
                                  CalcUtils.removeLastCharacter(_dataToCount);
                            } else if (i == "CE") {
                              _dataToCount = "0";
                              _result = "0";
                            } else if (i == "=") {
                              if (CalcUtils.checkIfLastCharacterIsOperator(
                                  _dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    _dataToCount.interpret().toStringAsFixed(2);
                                _result =
                                    (CalcUtils.checkIfLastCharacterIsRoundable(
                                            temp))
                                        ? temp.substring(0, temp.length - 3)
                                        : temp;
                                CustomLogger.info("get result $_result");
                              }
                            } else {
                              _dataToCount += i;
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    } else {
      return const Center(
        child: Text("Unknown Platform"),
      );
    }
  }
}
