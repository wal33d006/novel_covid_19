import 'package:flutter/material.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/navigation/close_route.dart';
import 'package:novel_covid_19/navigation/error_dialog_route.dart';
import 'package:novel_covid_19/ui/global_info/global_info_initial_params.dart';
import 'package:novel_covid_19/ui/global_info/global_info_page.dart';

class GlobalInfoNavigator with CloseRoute<void>, ErrorDialogRoute {
  GlobalInfoNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin GlobalInfoRoute {
  Future<void> openGlobalInfo(GlobalInfoInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(
        getIt<GlobalInfoPage>(param1: initialParams),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
