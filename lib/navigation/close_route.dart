import 'package:flutter/material.dart';
import 'package:novel_covid_19/navigation/app_navigator.dart';

mixin CloseRoute<T> {
  BuildContext get context;

  AppNavigator get appNavigator;

  void close() => appNavigator.close(context);

  void closeWithResult(T? result) => appNavigator.closeWithResult(context, result);
}