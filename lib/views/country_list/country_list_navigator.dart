import 'package:flutter/material.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/navigation/close_route.dart';
import 'package:novel_covid_19/navigation/error_dialog_route.dart';
import 'package:novel_covid_19/views/country_details/country_details_navigator.dart';
import 'package:novel_covid_19/views/country_list.dart';
import 'package:novel_covid_19/views/country_list/country_list_initial_params.dart';

class CountryListNavigator with CloseRoute<void>, CountryDetailsRoute, ErrorDialogRoute {
  CountryListNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin CountryListRoute {
  Future<void> openCountryList(CountryListInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(
        getIt<CountryListPage>(param1: initialParams),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
