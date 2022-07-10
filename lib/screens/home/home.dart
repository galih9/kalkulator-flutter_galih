import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_tree/function_tree.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator/screens/home/web/web_view.dart';
import 'package:kalkulator/screens/home/windows/win_views.dart';
import 'package:kalkulator/screens/widgets/home_widgets.dart';
import 'package:kalkulator/utils/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shimmer/shimmer.dart';
import 'dart:io' show Platform;
import 'package:sizer/sizer.dart';

import '../../blocs/home_bloc.dart';

part './mobile/mobile_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _list = CalcUtils.getButtonLabels();
  final List<String> _listLandscape = CalcUtils.getButtonLandscapeLabels();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadData());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: LayoutBuilder(builder: (context, constraint) {
          return WebViewCalc(
            result: "",
            dataCount: "",
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
                        if (i == "Del") {
                          context.read<HomeBloc>().add(
                                DeleteNumber(dataCount: i),
                              );
                        } else if (i == "CE") {
                          context.read<HomeBloc>().add(
                                const DeleteEverything(),
                              );
                        } else if (i == "=") {
                          context.read<HomeBloc>().add(
                                const CalculateResult(),
                              );
                        } else {
                          context.read<HomeBloc>().add(
                                AddNumber(dataCount: i),
                              );
                        }
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
            list: _list,
            listLandscape: _listLandscape,
          );
        },
      );
    } else if (Platform.isWindows) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: LayoutBuilder(builder: (context, constraint) {
          return WinViewCalc(
            result: "",
            dataCount: "",
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
                        if (i == "Del") {
                          context.read<HomeBloc>().add(
                                DeleteNumber(dataCount: i),
                              );
                        } else if (i == "CE") {
                          context.read<HomeBloc>().add(
                                const DeleteEverything(),
                              );
                        } else if (i == "=") {
                          context.read<HomeBloc>().add(
                                const CalculateResult(),
                              );
                        } else {
                          context.read<HomeBloc>().add(
                                AddNumber(dataCount: i),
                              );
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const Center(
          child: Text("Unknown Platform"),
        ),
      );
    }
  }
}
