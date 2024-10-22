import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/home_bloc.dart';
import '../../../utils/logger.dart';
import '../../widgets/home_widgets.dart';

class WebViewCalc extends StatelessWidget {
  final List<String> list;
  final List<String> listLandscape;
  final AudioPlayer typePlayer;
  final AudioPlayer errorPlayer;

  const WebViewCalc({
    Key? key,
    required this.list,
    required this.listLandscape,
    required this.typePlayer,
    required this.errorPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          if (state.warningMessage.isNotEmpty) {
            CalcUtils.showSnackbar(context, state.warningMessage);
            CalcUtils.playAudio(errorPlayer, "e");
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: LayoutBuilder(
          builder: (context, constraint) {
            if (constraint.maxWidth > 600) {
              return wideCalcView(context, listLandscape, typePlayer);
            } else if (constraint.maxWidth > 1000) {
              return ultraWideCalcView();
            } else {
              return narrowCalcView(context, listLandscape, typePlayer);
            }
          },
        ),
      ),
    );
  }
}

Widget ultraWideCalcView() {
  return Center(
    child: Text(
      "Ultra Wide mode still under construction",
      style: GoogleFonts.roboto(
        fontSize: 30.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget narrowCalcView(
  BuildContext context,
  List<String> list,
  AudioPlayer player,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Row(
            children: [
              HeaderLabelView(
                label: "result",
                color: Colors.amber,
                width: 40.w,
                paddingVert: 2.h,
                padingHoriz: 5.w,
                fontSize: 15.sp,
              ),
              if (state is HomeInitial || state is HomeLoadResult)
                ValueLabelView(
                  isLoading: true,
                  color: Colors.amberAccent,
                  width: 60.w,
                  fontSize: 15.sp,
                )
              else if (state is HomeLoaded)
                ValueLabelView(
                  isLoading: false,
                  color: Colors.amberAccent,
                  value: state.result,
                  width: 60.w,
                  fontSize: 15.sp,
                ),
            ],
          );
        },
      ),
      BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Row(
            children: [
              HeaderLabelView(
                label: "value",
                color: Colors.green,
                width: 40.w,
                paddingVert: 2.h,
                padingHoriz: 5.w,
                fontSize: 15.sp,
              ),
              if (state is HomeInitial || state is HomeLoadResult)
                ValueLabelView(
                  isLoading: true,
                  color: Colors.greenAccent,
                  width: 60.w,
                  fontSize: 15.sp,
                )
              else if (state is HomeLoaded)
                ValueLabelView(
                  isLoading: false,
                  color: Colors.greenAccent,
                  value: state.dataCount,
                  width: 60.w,
                  fontSize: 15.sp,
                ),
            ],
          );
        },
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
        child: Center(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            children: [
              for (var i in list)
                CalculatorButtons(
                  btnStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
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
                    CalcUtils.playAudio(player, "c");
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
            ],
          ),
        ),
      ),
    ],
  );
}

Widget wideCalcView(
  BuildContext context,
  List<String> list,
  AudioPlayer player,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    height: 100.h,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 2.w),
          height: 50.h,
          width: 30.w,
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            children: [
              for (var i in list)
                CalculatorButtons(
                  btnStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      ((CalcUtils.isNumericUsingRegularExpression(i))
                          ? Colors.blueGrey
                          : (i == "=")
                              ? Colors.blue
                              : Colors.grey),
                    ),
                  ),
                  label: i,
                  fontSize: 3.sp,
                  onPressed: () {
                    CalcUtils.playAudio(player, "c");
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 2.w),
          height: 50.h,
          width: 30.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      HeaderLabelView(
                        width: 10.w,
                        color: Colors.amber,
                        label: "result",
                        paddingVert: 2.h,
                        padingHoriz: 2.w,
                        fontSize: 5.sp,
                      ),
                      if (state is HomeInitial || state is HomeLoadResult)
                        ValueLabelView(
                          isLoading: true,
                          color: Colors.amberAccent,
                          width: 20.w,
                          fontSize: 5.sp,
                        )
                      else if (state is HomeLoaded)
                        ValueLabelView(
                          isLoading: false,
                          color: Colors.amberAccent,
                          width: 20.w,
                          value: state.result,
                          fontSize: 5.sp,
                        ),
                    ],
                  );
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      HeaderLabelView(
                        width: 10.w,
                        color: Colors.green,
                        label: "value",
                        paddingVert: 2.h,
                        padingHoriz: 2.w,
                        fontSize: 5.sp,
                      ),
                      if (state is HomeInitial || state is HomeLoadResult)
                        ValueLabelView(
                          isLoading: true,
                          color: Colors.greenAccent,
                          width: 20.w,
                          fontSize: 5.sp,
                        )
                      else if (state is HomeLoaded)
                        ValueLabelView(
                          isLoading: false,
                          color: Colors.greenAccent,
                          width: 20.w,
                          value: state.dataCount,
                          fontSize: 5.sp,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
