import 'package:flutter/material.dart';

import '../../../utils/logger.dart';
import '../../widgets/home_widgets.dart';

class WebViewCalc extends StatelessWidget {
  final String result;
  final String dataCount;
  final List<String> list;
  final Function(String) onPressed;
  final Orientation orientation;

  const WebViewCalc({
    Key? key,
    required this.result,
    required this.dataCount,
    required this.list,
    required this.onPressed,
    required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Demo Home Page'),
      // ),
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                children: [
                  for (var i in list)
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
                      onPressed: onPressed(i),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
