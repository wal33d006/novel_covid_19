import 'package:flutter/material.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/navigation/close_route.dart';
import 'package:novel_covid_19/navigation/error_dialog_route.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_initial_params.dart';
import 'package:novel_covid_19/ui/master_home_page/master_home_page.dart';

class MasterHomeNavigator with CloseRoute<void>, ErrorDialogRoute {
  MasterHomeNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin MasterHomeRoute {
  Future<void> openMasterHome(MasterHomeInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(
        getIt<MasterHomePage>(param1: initialParams),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
