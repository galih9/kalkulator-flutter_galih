part of '../home.dart';

class MobileViewCalc extends StatelessWidget {
  final Orientation orientation;
  final List<String> list;
  final List<String> listLandscape;

  const MobileViewCalc({
    Key? key,
    required this.orientation,
    required this.list,
    required this.listLandscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          if (state.warningMessage.isNotEmpty) {
            CalcUtils.showSnackbar(context, state.warningMessage);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: (orientation == Orientation.portrait)
            ? Column(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                    child: Center(
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        children: [
                          for (var i in list)
                            CalculatorButtons(
                              btnStyle: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  ((CalcUtils.isNumericUsingRegularExpression(
                                          i))
                                      ? Colors.blueGrey
                                      : (i == "=")
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ),
                              label: i,
                              fontSize: 13.sp,
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
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w),
                        height: 100.h,
                        child: Center(
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                            children: [
                              for (var i in listLandscape)
                                CalculatorButtons(
                                  btnStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      ((CalcUtils
                                              .isNumericUsingRegularExpression(
                                                  i))
                                          ? Colors.blueGrey
                                          : (i == "=")
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ),
                                  label: i,
                                  fontSize: 13.sp,
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
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    HeaderLabelView(
                                      label: "result",
                                      color: Colors.amber,
                                      width: 30.w,
                                      paddingVert: 2.h,
                                      padingHoriz: 5.w,
                                      fontSize: 15.sp,
                                    ),
                                    if (state is HomeInitial ||
                                        state is HomeLoadResult)
                                      ValueLabelView(
                                        isLoading: true,
                                        color: Colors.amberAccent,
                                        width: 41.w,
                                        fontSize: 15.sp,
                                      )
                                    else if (state is HomeLoaded)
                                      ValueLabelView(
                                        isLoading: false,
                                        color: Colors.amberAccent,
                                        width: 41.w,
                                        fontSize: 15.sp,
                                        value: state.result,
                                      )
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
                                      width: 30.w,
                                      paddingVert: 2.h,
                                      padingHoriz: 5.w,
                                      fontSize: 15.sp,
                                    ),
                                    if (state is HomeInitial ||
                                        state is HomeLoadResult)
                                      ValueLabelView(
                                        isLoading: true,
                                        color: Colors.greenAccent,
                                        width: 41.w,
                                        fontSize: 15.sp,
                                      )
                                    else if (state is HomeLoaded)
                                      ValueLabelView(
                                        isLoading: false,
                                        color: Colors.greenAccent,
                                        width: 41.w,
                                        value: state.dataCount,
                                        fontSize: 15.sp,
                                      )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
