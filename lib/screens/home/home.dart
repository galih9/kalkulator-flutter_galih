// core import
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
// package import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
// local library import
import '../../screens/home/web/web_view.dart';
import '../../screens/home/windows/win_views.dart';
import '../../screens/widgets/home_widgets.dart';
import '../../utils/logger.dart';
import '../../blocs/home_bloc.dart';
// partition import
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
      return WebViewCalc(
        list: _list,
        listLandscape: _listLandscape,
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
        body: LayoutBuilder(
          builder: (context, constraint) {
            return WinViewCalc(
              list: _list,
              listLandscape: _listLandscape,
            );
          },
        ),
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
