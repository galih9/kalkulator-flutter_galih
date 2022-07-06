import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:kalkulator/screens/widgets/home_widgets.dart';
import 'package:kalkulator/utils/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataToCount = "0";
  String result = "0";
  final List<String> _list = CalcUtils.getButtonLabels();

  @override
  void initState() {
    super.initState();
  }

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
            value: result,
            color: Colors.amberAccent,
            colorLabel: Colors.amber,
            label: "result",
          ),
          HeaderDisplayer(
            value: dataToCount,
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
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (dataToCount == "0") {
                              if (CalcUtils.isNumericUsingRegularExpression(
                                  i)) {
                                dataToCount = i;
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
                              dataToCount =
                                  CalcUtils.removeLastCharacter(dataToCount);
                            } else if (i == "CE") {
                              dataToCount = "0";
                            } else if (i == "=") {
                              if (CalcUtils.checkIfLastCharacterIsOperator(
                                  dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                CalcUtils.showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    dataToCount.interpret().toStringAsFixed(2);
                                result =
                                    (CalcUtils.checkIfLastCharacterIsRoundable(
                                            temp))
                                        ? temp.substring(0, temp.length - 3)
                                        : temp;
                                CustomLogger.info("get result $result");
                              }
                            } else {
                              dataToCount += i;
                            }
                          },
                        );
                      },
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
