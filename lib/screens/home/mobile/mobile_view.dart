part of '../home.dart';

class MobileViewCalc extends StatelessWidget {
  final String result;
  final String dataCount;
  final GridView buttons;
  final Orientation orientation;

  const MobileViewCalc({
    Key? key,
    required this.result,
    required this.dataCount,
    required this.buttons,
    required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (orientation == Orientation.portrait)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderDisplayer(
                  orientation: orientation,
                  value: result,
                  color: Colors.amberAccent,
                  colorLabel: Colors.amber,
                  label: "result",
                ),
                HeaderDisplayer(
                  orientation: orientation,
                  value: dataCount,
                  color: Colors.greenAccent,
                  colorLabel: Colors.green,
                  label: "value",
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                  child: Center(
                    child: buttons,
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
                      child: buttons,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(right: 2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeaderDisplayer(
                            orientation: orientation,
                            value: result,
                            color: Colors.amberAccent,
                            colorLabel: Colors.amber,
                            label: "result",
                          ),
                          HeaderDisplayer(
                            orientation: orientation,
                            value: dataCount,
                            color: Colors.greenAccent,
                            colorLabel: Colors.green,
                            label: "value",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
