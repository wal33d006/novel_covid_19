import 'package:flutter/material.dart';
import 'package:novel_covid_19/main.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';
import 'package:novel_covid_19/navigation/close_route.dart';
import 'package:novel_covid_19/views/country_details/country_details_initial_params.dart';
import 'package:novel_covid_19/views/country_details/country_details_page.dart';

class CountryDetailsNavigator with CloseRoute<void> {
  CountryDetailsNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin CountryDetailsRoute {
  Future<void> openCountryDetails(CountryDetailsInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(
        getIt<CountryDetailsPage>(param1: initialParams),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
