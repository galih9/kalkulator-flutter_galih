import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/home_widgets.dart';

class WebViewCalc extends StatelessWidget {
  final String result;
  final String dataCount;
  final GridView buttons;
  final BoxConstraints constraints;

  const WebViewCalc({
    Key? key,
    required this.result,
    required this.dataCount,
    required this.buttons,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (constraints.maxWidth > 600) {
      return wideCalcView(dataCount, result, buttons);
    } else {
      return narrowCalcView(dataCount, result, buttons);
    }
  }
}

Widget narrowCalcView(String dataCount, String result, GridView buttons) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      HeaderDisplayer(
        labelWidth: 40.w,
        valueWidth: 60.w,
        orientation: Orientation.portrait,
        value: result,
        color: Colors.amberAccent,
        colorLabel: Colors.amber,
        label: "result",
      ),
      HeaderDisplayer(
        labelWidth: 40.w,
        valueWidth: 60.w,
        orientation: Orientation.portrait,
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
  );
}

Widget wideCalcView(
  String dataCount,
  String result,
  GridView buttons,
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
          child: buttons,
        ),
        Container(
          margin: EdgeInsets.only(right: 2.w),
          height: 50.h,
          width: 30.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    width: 10.w,
                    color: Colors.amber,
                    child: Text(
                      "result",
                      style: GoogleFonts.poppins(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.amberAccent,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    width: 20.w,
                    child: Text(
                      result,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    width: 10.w,
                    color: Colors.green,
                    child: Text(
                      "value",
                      style: GoogleFonts.poppins(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.greenAccent,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    width: 20.w,
                    child: Text(
                      dataCount,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
